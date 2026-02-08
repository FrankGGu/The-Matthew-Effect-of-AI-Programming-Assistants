class Solution:
    def eventualSafeNodes(self, graph: List[List[int]]) -> List[int]:
        n = len(graph)
        color = [0] * n

        def dfs(node):
            if color[node] != 0:
                return color[node]
            color[node] = 1
            for neighbor in graph[node]:
                if dfs(neighbor) == 1:
                    return 1
            color[node] = 2
            return 2

        for i in range(n):
            if color[i] == 0:
                dfs(i)

        return [i for i in range(n) if color[i] == 2]