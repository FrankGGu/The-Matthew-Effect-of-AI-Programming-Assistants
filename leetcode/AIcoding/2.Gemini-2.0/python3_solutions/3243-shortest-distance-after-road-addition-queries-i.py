class Solution:
    def shortestDistance(self, n: int, edges: list[list[int]], queries: list[list[int]]) -> list[int]:
        dist = [[float('inf')] * n for _ in range(n)]
        for i in range(n):
            dist[i][i] = 0
        for u, v in edges:
            dist[u][v] = 1
            dist[v][u] = 1
        for k in range(n):
            for i in range(n):
                for j in range(n):
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
        ans = []
        for u, v, w in queries:
            temp_dist = [row[:] for row in dist]
            for i in range(n):
                for j in range(n):
                    temp_dist[i][j] = min(temp_dist[i][j], temp_dist[i][u] + w + temp_dist[v][j], temp_dist[i][v] + w + temp_dist[u][j])
            min_dist = float('inf')
            for i in range(n):
                for j in range(i + 1, n):
                    min_dist = min(min_dist, temp_dist[i][j])
            if min_dist == float('inf'):
                ans.append(-1)
            else:
                ans.append(min_dist)
        return ans