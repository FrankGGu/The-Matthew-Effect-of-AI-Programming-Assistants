class Solution:
    def restoreArray(self, adjacentPairs: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for a, b in adjacentPairs:
            graph[a].append(b)
            graph[b].append(a)

        result = []
        visited = set()

        def dfs(node):
            visited.add(node)
            result.append(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor)

        dfs(adjacentPairs[0][0])
        return result