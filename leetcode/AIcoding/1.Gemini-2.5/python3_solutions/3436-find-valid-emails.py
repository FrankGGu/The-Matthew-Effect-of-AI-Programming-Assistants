class Solution:
    def numUniqueEmails(self, emails: List[str]) -> int:
        unique_emails = set()
        for email in emails:
            local_name, domain_name = email.split('@')

            processed_local_name_parts = []
            for char in local_name:
                if char == '.':
                    continue
                if char == '+':
                    break
                processed_local_name_parts.append(char)

            cleaned_local_name = "".join(processed_local_name_parts)

            unique_emails.add(f"{cleaned_local_name}@{domain_name}")

        return len(unique_emails)