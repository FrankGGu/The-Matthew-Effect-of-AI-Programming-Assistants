class DSU:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        self.parent[self.find(x)] = self.find(y)

class Solution:
    def accountsMerge(self, accounts: list[list[str]]) -> list[list[str]]:
        email_to_name = {}
        email_to_index = {}
        index = 0
        dsu = DSU(len(accounts))

        for i, account in enumerate(accounts):
            name = account[0]
            for j in range(1, len(account)):
                email = account[j]
                email_to_name[email] = name
                if email not in email_to_index:
                    email_to_index[email] = i
                else:
                    dsu.union(i, email_to_index[email])

        index_to_emails = {}
        for email, i in email_to_index.items():
            root = dsu.find(i)
            if root not in index_to_emails:
                index_to_emails[root] = []
            index_to_emails[root].append(email)

        result = []
        for i, emails in index_to_emails.items():
            name = accounts[i][0]
            emails.sort()
            result.append([name] + emails)

        return result