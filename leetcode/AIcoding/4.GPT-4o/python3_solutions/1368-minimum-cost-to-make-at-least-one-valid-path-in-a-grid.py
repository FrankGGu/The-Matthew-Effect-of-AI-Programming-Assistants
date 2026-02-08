import heapq

class Solution:
    def minCost(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        cost = [[float('inf')] * n for _ in range(m)]
        cost[0][0] = 0
        pq = [(0, 0, 0)]  # cost, x, y

        while pq:
            c, x, y = heapq.heappop(pq)
            if x == m - 1 and y == n - 1:
                return c

            for d in range(4):
                nx, ny = x + directions[d][0], y + directions[d][1]
                if 0 <= nx < m and 0 <= ny < n:
                    new_cost = c + (1 if grid[x][y] != d + 1 else 0)
                    if new_cost < cost[nx][ny]:
                        cost[nx][ny] = new_cost
                        heapq.heappush(pq, (new_cost, nx, ny))

        return cost[m - 1][n - 1]