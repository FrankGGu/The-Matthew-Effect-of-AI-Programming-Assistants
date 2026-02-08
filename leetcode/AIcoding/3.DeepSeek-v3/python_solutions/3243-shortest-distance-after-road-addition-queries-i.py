class Solution:
    def shortestDistance(self, n: int, roads: List[List[int]], queries: List[List[int]]) -> List[int]:
        INF = float('inf')
        dist = [[INF] * n for _ in range(n)]
        for i in range(n):
            dist[i][i] = 0

        for u, v, w in roads:
            dist[u][v] = w
            dist[v][u] = w

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    if dist[i][k] + dist[k][j] < dist[i][j]:
                        dist[i][j] = dist[i][k] + dist[k][j]

        res = []
        for u, v in queries:
            res.append(dist[u][v] if dist[u][v] != INF else -1)
        return res