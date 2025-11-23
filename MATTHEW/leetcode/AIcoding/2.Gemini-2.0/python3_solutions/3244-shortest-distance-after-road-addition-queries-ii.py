import heapq

class Solution:
    def shortestDistance(self, n: int, edges: list[list[int]], queries: list[list[int]]) -> list[int]:
        dist = [[float('inf')] * n for _ in range(n)]
        for i in range(n):
            dist[i][i] = 0
        for u, v, w in edges:
            dist[u][v] = w
            dist[v][u] = w

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])

        ans = []
        for u, v, w in queries:
            temp_dist = [[float('inf')] * n for _ in range(n)]
            for i in range(n):
                temp_dist[i][i] = 0

            for i in range(n):
                for j in range(n):
                    temp_dist[i][j] = dist[i][j]

            for i in range(n):
                for j in range(n):
                    temp_dist[i][j] = min(temp_dist[i][j], min(temp_dist[i][u] + w + dist[v][j], temp_dist[i][v] + w + dist[u][j]))

            min_dist = float('inf')
            for i in range(n):
                for j in range(n):
                    if i != j:
                        min_dist = min(min_dist, temp_dist[i][j])
            if min_dist == float('inf'):
                ans.append(-1)
            else:
                ans.append(min_dist)
        return ans