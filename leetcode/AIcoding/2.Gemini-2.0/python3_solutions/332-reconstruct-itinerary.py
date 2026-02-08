from collections import defaultdict

class Solution:
    def findItinerary(self, tickets: list[list[str]]) -> list[str]:
        graph = defaultdict(list)
        for start, end in tickets:
            graph[start].append(end)

        for start in graph:
            graph[start].sort(reverse=True)

        result = []

        def dfs(node):
            while graph[node]:
                dfs(graph[node].pop())
            result.append(node)

        dfs("JFK")
        return result[::-1]