from collections import deque

class Solution:
    def maxDistance(self, grid: list[list[int]]) -> int:
        n = len(grid)
        q = deque()
        land_count = 0
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    q.append((i, j))
                    land_count += 1

        if land_count == 0 or land_count == n * n:
            return -1

        dist = -1
        while q:
            dist += 1
            size = len(q)
            for _ in range(size):
                x, y = q.popleft()
                for dx, dy in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] == 0:
                        grid[nx][ny] = 1
                        q.append((nx, ny))

        return dist