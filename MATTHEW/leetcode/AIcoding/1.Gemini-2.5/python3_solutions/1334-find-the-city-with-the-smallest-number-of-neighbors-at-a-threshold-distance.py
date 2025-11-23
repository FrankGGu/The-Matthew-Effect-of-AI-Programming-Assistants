import math

class Solution:
    def findTheCity(self, n: int, edges: list[list[int]], distanceThreshold: int) -> int:
        dist = [[math.inf] * n for _ in range(n)]

        for i in range(n):
            dist[i][i] = 0

        for u, v, w in edges:
            dist[u][v] = w
            dist[v][u] = w

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    if dist[i][k] != math.inf and dist[k][j] != math.inf:
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])

        min_neighbors = n + 1
        result_city = -1

        for i in range(n - 1, -1, -1):
            current_neighbors = 0
            for j in range(n):
                if i != j and dist[i][j] <= distanceThreshold:
                    current_neighbors += 1

            if current_neighbors <= min_neighbors:
                min_neighbors = current_neighbors
                result_city = i

        return result_city