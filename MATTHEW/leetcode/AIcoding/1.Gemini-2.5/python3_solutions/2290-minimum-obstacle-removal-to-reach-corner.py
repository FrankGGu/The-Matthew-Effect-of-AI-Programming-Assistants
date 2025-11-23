import collections
import math

class Solution:
    def minimumObstacles(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        dist = [[math.inf] * n for _ in range(m)]
        deque = collections.deque()

        dist[0][0] = 0
        deque.append((0, 0, 0)) # (cost, row, col)

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while deque:
            cost, r, c = deque.popleft()

            if r == m - 1 and c == n - 1:
                return cost

            if cost > dist[r][c]:
                continue

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n:
                    new_cost = cost + grid[nr][nc]
                    if new_cost < dist[nr][nc]:
                        dist[nr][nc] = new_cost
                        if grid[nr][nc] == 0:
                            deque.appendleft((new_cost, nr, nc))
                        else:
                            deque.append((new_cost, nr, nc))
        return -1 # Should not be reached given problem constraints