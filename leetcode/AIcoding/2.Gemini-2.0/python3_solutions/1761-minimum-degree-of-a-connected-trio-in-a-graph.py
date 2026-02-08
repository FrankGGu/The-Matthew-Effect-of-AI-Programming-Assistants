class Solution:
    def minTrioDegree(self, n: int, edges: list[list[int]]) -> int:
        adj = [[False] * (n + 1) for _ in range(n + 1)]
        degree = [0] * (n + 1)
        for u, v in edges:
            adj[u][v] = adj[v][u] = True
            degree[u] += 1
            degree[v] += 1

        min_degree = float('inf')
        for i in range(1, n + 1):
            for j in range(i + 1, n + 1):
                if adj[i][j]:
                    for k in range(j + 1, n + 1):
                        if adj[i][k] and adj[j][k]:
                            min_degree = min(min_degree, degree[i] + degree[j] + degree[k] - 6)

        return min_degree if min_degree != float('inf') else -1