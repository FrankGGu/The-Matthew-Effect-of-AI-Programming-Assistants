class Solution:
    def restoreArray(self, adjacentPairs: List[int]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        n = len(adjacentPairs)
        for i in range(0, n, 2):
            a, b = adjacentPairs[i], adjacentPairs[i + 1]
            graph[a].append(b)
            graph[b].append(a)

        start = None
        for key in graph:
            if len(graph[key]) == 1:
                start = key
                break

        result = []
        visited = set()

        def dfs(node):
            visited.add(node)
            result.append(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor)

        dfs(start)
        return result