class Solution:
    def findTheCity(self, n: int, edges: List[List[int], distanceThreshold: int) -> int:
        graph = [[float('inf')] * n for _ in range(n)]
        for u, v, w in edges:
            graph[u][v] = graph[v][u] = w

        for i in range(n):
            graph[i][i] = 0

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    graph[i][j] = min(graph[i][j], graph[i][k] + graph[k][j])

        result = -1
        count = float('inf')

        for i in range(n):
            reachable = sum(1 for j in range(n) if graph[i][j] <= distanceThreshold)
            if reachable <= count:
                count = reachable
                result = i

        return result