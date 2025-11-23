from collections import deque

class Solution:
    def minCost(self, grid):
        m, n = len(grid), len(grid[0])
        cost = [[float('inf')] * n for _ in range(m)]
        cost[0][0] = 0
        dq = deque()
        dq.append((0, 0))

        directions = {1: (0, 1), 2: (0, -1), 3: (1, 0), 4: (-1, 0)}

        while dq:
            x, y = dq.popleft()
            current_cost = cost[x][y]

            for direction, (dx, dy) in directions.items():
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    new_cost = current_cost + (0 if grid[x][y] == direction else 1)
                    if new_cost < cost[nx][ny]:
                        cost[nx][ny] = new_cost
                        dq.append((nx, ny))

        return cost[m-1][n-1]