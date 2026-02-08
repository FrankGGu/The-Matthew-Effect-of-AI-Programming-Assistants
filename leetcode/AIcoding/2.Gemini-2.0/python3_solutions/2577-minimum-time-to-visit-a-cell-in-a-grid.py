import heapq

class Solution:
    def minimumTime(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        if grid[0][1] > 1 and grid[1][0] > 1:
            return -1

        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 0

        pq = [(0, 0, 0)] 

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
                    wait_time = max(0, grid[nr][nc] - d - 1)
                    new_dist = d + wait_time + 1

                    if new_dist < dist[nr][nc]:
                        dist[nr][nc] = new_dist
                        heapq.heappush(pq, (new_dist, nr, nc))

        return -1