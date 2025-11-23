class Solution:
    def possibleBipartition(self, n: int, dislikes: List[List[int]]) -> bool:
        graph = [[] for _ in range(n)]
        for u, v in dislikes:
            graph[u - 1].append(v - 1)
            graph[v - 1].append(u - 1)

        colors = [0] * n

        def dfs(node, color):
            colors[node] = color
            for neighbor in graph[node]:
                if colors[neighbor] == 0:
                    if not dfs(neighbor, -color):
                        return False
                elif colors[neighbor] == color:
                    return False
            return True

        for i in range(n):
            if colors[i] == 0:
                if not dfs(i, 1):
                    return False

        return True