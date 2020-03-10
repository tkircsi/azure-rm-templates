RESOURCEGROUP=learn-quickstart-vm-rg
LOCATION=westeurope
az group create --name $RESOURCEGROUP --location $LOCATION

USERNAME=azureuser
PASSWORD=$(openssl rand -base64 32)
DNS_LABEL_PREFIX=mydeployment-$RANDOM
echo "USERANME: $USERNAME"
echo "PASSWORD: $PASSWORD"

az group deployment validate \
  --resource-group $RESOURCEGROUP \
  --template-uri "https://raw.githubusercontent.com/tkircsi/azure-rm-templates/master/azuredeploy.json" \
  --parameters adminUsername=$USERNAME \
  --parameters adminPassword=$PASSWORD \
  --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

az group deployment create \
  --name MyDeployment \
  --resource-group $RESOURCEGROUP \
  --template-uri "https://raw.githubusercontent.com/tkircsi/azure-rm-templates/master/azuredeploy.json" \
  --parameters adminUsername=$USERNAME \
  --parameters adminPassword=$PASSWORD \
  --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX

az group deployment show \
  --name MyDeployment \
  --resource-group $RESOURCEGROUP

az vm list \
  --resource-group $RESOURCEGROUP \
  --output table