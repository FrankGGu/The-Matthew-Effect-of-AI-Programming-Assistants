def numOfValidEmails(emails):
    valid_count = 0
    for email in emails:
        local, domain = email.split('@')
        if len(local) > 0 and len(domain) > 0:
            if '.' in domain and local.replace('.', '').replace('+', '').isalpha():
                valid_count += 1
    return valid_count