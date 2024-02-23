#!/bin/bash

# This script with fetch credentials from 1Password and pass it to the script in the arguments
# It will grab Jamf username, password, and snipe api key
# Adjust vault item names as needed
# Requirements
#   - Virtual Environment that is setup for jamf2snipe (delete lines if you do not use a venv)
#   - op cli
#   - Snipe Key 1Password entry is stored as an "API Credential"

echo "Activating jamf2snipe venv.."
source ~/.venv/jamf2snipe/bin/activate

# Retrieve password for Jamf account
echo "Retrieving credentials from 1Password.."
jamf_username=$(op item get "ITEM_NAME" --vault Private --fields label=username)
jamf_password=$(op item get "ITEM_NAME" --vault Private --fields label=password)
snipe_api_key=$(op item get "ITEM_NAME" --vault Private --fields label=credential)

# Run the Python script with fetched credentials, remove "--dryrun" when ready to run
python3 jamf2snipe --dryrun --verbose -u -r --jamf-user "$jamf_username" --jamf-password "$jamf_password" --snipe-key "$snipe_api_key"

deactivate