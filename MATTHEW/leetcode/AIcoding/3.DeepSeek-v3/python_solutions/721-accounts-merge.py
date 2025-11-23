class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root != y_root:
            self.parent[y_root] = x_root

class Solution:
    def accountsMerge(self, accounts: List[List[str]]) -> List[List[str]]:
        email_to_id = {}
        email_to_name = {}
        id_counter = 0

        for account in accounts:
            name = account[0]
            emails = account[1:]
            for email in emails:
                if email not in email_to_id:
                    email_to_id[email] = id_counter
                    email_to_name[email] = name
                    id_counter += 1

        uf = UnionFind(id_counter)
        for account in accounts:
            emails = account[1:]
            first_email_id = email_to_id[emails[0]]
            for email in emails[1:]:
                uf.union(first_email_id, email_to_id[email])

        id_to_emails = {}
        for email, id_ in email_to_id.items():
            root_id = uf.find(id_)
            if root_id not in id_to_emails:
                id_to_emails[root_id] = []
            id_to_emails[root_id].append(email)

        merged_accounts = []
        for id_ in id_to_emails:
            name = email_to_name[id_to_emails[id_][0]]
            merged_accounts.append([name] + sorted(id_to_emails[id_]))

        return merged_accounts