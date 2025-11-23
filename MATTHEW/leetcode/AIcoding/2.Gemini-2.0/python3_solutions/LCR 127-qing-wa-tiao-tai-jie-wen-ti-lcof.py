class Solution:
    def minimumObstacles(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = grid[0][0]
        pq = [(dist[0][0], 0, 0)]

        while pq:
            d, x, y = heapq.heappop(pq)

            if d > dist[x][y]:
                continue

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            for dx, dy in directions:
                nx, ny = x + dx, y + dy

                if 0 <= nx < m and 0 <= ny < n:
                    weight = grid[nx][ny]
                    if dist[nx][ny] > dist[x][y] + weight:
                        dist[nx][ny] = dist[x][y] + weight
                        heapq.heappush(pq, (dist[nx][ny], nx, ny))

        return dist[m-1][n-1]