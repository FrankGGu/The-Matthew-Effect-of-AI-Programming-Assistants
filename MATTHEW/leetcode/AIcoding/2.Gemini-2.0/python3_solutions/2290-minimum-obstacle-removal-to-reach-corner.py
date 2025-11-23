import heapq

class Solution:
    def minimumObstacles(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = grid[0][0]
        pq = [(dist[0][0], 0, 0)]

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while pq:
            d, r, c = heapq.heappop(pq)

            if d > dist[r][c]:
                continue

            if r == m - 1 and c == n - 1:
                return d

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n:
                    new_dist = d + grid[nr][nc]
                    if new_dist < dist[nr][nc]:
                        dist[nr][nc] = new_dist
                        heapq.heappush(pq, (new_dist, nr, nc))

        return dist[m - 1][n - 1]