class Solution:
    def numUniqueEmails(self, emails: list[str]) -> int:
        unique_emails = set()
        for email in emails:
            local, domain = email.split('@')
            local = local.split('+')[0].replace('.', '')
            unique_email = local + '@' + domain
            unique_emails.add(unique_email)
        return len(unique_emails)