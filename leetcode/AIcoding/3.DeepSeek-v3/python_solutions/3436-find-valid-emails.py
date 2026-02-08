import re

def valid_emails(emails):
    pattern = r'^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\.com$'
    valid = []
    for email in emails:
        if re.match(pattern, email):
            valid.append(email)
    return valid