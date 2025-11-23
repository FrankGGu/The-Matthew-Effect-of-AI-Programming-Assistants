class Solution:
    def isBipartite(self, graph: List[List[int]]) -> bool:
        color = {}

        def dfs(node):
            for neighbor in graph[node]:
                if neighbor in color:
                    if color[neighbor] == color[node]:
                        return False
                else:
                    color[neighbor] = 1 - color[node]
                    if not dfs(neighbor):
                        return False
            return True

        for i in range(len(graph)):
            if i not in color:
                color[i] = 0
                if not dfs(i):
                    return False
        return True