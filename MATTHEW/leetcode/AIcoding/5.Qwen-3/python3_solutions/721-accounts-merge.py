class Solution:
    def accountsMerge(self, accounts: List[List[str]]) -> List[List[str]]:
        from collections import defaultdict, deque

        email_to_name = {}
        graph = defaultdict(set)

        for account in accounts:
            name = account[0]
            emails = account[1:]
            email_to_name[emails[0]] = name
            for email in emails:
                graph[emails[0]].add(email)
                graph[email].add(emails[0])

        visited = set()
        result = []

        for email in graph:
            if email not in visited:
                queue = deque([email])
                visited.add(email)
                merged_emails = []
                while queue:
                    current = queue.popleft()
                    merged_emails.append(current)
                    for neighbor in graph[current]:
                        if neighbor not in visited:
                            visited.add(neighbor)
                            queue.append(neighbor)
                name = email_to_name[email]
                result.append([name] + sorted(merged_emails))

        return result