import heapq

class Solution:
    def minCost(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 0
        pq = [(0, 0, 0)]
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while pq:
            cost, r, c = heapq.heappop(pq)

            if cost > dist[r][c]:
                continue

            for i in range(4):
                dr, dc = directions[i]
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n:
                    new_cost = cost + (0 if grid[r][c] == i + 1 else 1)
                    if new_cost < dist[nr][nc]:
                        dist[nr][nc] = new_cost
                        heapq.heappush(pq, (new_cost, nr, nc))

        return dist[m - 1][n - 1]