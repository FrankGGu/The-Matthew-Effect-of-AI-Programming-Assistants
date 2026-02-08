class Solution:
    def accountsMerge(self, accounts: List[List[str]]) -> List[List[str]]:
        from collections import defaultdict

        email_to_name = {}
        graph = defaultdict(set)

        # Build the graph and the email-to-name mapping
        for account in accounts:
            name = account[0]
            for email in account[1:]:
                email_to_name[email] = name
                graph[account[1]].add(email)
                graph[email].add(account[1])

        visited = set()
        result = []

        # DFS to find all connected components
        def dfs(email):
            visited.add(email)
            merged_emails = [email]
            for neighbor in graph[email]:
                if neighbor not in visited:
                    merged_emails.extend(dfs(neighbor))
            return merged_emails

        for email in graph:
            if email not in visited:
                merged_emails = dfs(email)
                result.append([email_to_name[email]] + sorted(merged_emails))

        return result