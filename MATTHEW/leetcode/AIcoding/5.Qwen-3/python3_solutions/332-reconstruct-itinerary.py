class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        from collections import defaultdict

        graph = defaultdict(list)
        for src, dst in tickets:
            graph[src].append(dst)

        for key in graph:
            graph[key].sort()

        result = []

        def dfs(node):
            while graph[node]:
                next_node = graph[node].pop(0)
                dfs(next_node)
            result.append(node)

        dfs("JFK")
        return result[::-1]