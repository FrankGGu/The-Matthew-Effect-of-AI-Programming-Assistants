import collections

class Solution:
    def accountsMerge(self, accounts: list[list[str]]) -> list[list[str]]:
        email_to_id = {}
        id_to_email = {}
        email_to_name = {}
        parent = []
        id_counter = 0

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j
                return True
            return False

        for account in accounts:
            name = account[0]
            first_email_id = -1
            for i in range(1, len(account)):
                email = account[i]

                if email not in email_to_id:
                    email_to_id[email] = id_counter
                    id_to_email[id_counter] = email
                    parent.append(id_counter)
                    id_counter += 1

                current_email_id = email_to_id[email]
                email_to_name[email] = name

                if first_email_id == -1:
                    first_email_id = current_email_id
                else:
                    union(first_email_id, current_email_id)

        merged_emails_by_root = collections.defaultdict(list)
        for email_str, email_id in email_to_id.items():
            root_id = find(email_id)
            merged_emails_by_root[root_id].append(email_str)

        result = []
        for root_id, emails in merged_emails_by_root.items():
            sorted_emails = sorted(emails)
            representative_email = sorted_emails[0] 
            name = email_to_name[representative_email]
            result.append([name] + sorted_emails)

        return result