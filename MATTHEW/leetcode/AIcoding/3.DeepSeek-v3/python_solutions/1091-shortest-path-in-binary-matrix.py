from collections import deque

class Solution:
    def shortestPathBinaryMatrix(self, grid: List[List[int]]) -> int:
        if not grid or grid[0][0] == 1 or grid[-1][-1] == 1:
            return -1

        n = len(grid)
        directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

        queue = deque()
        queue.append((0, 0, 1))
        grid[0][0] = 1

        while queue:
            x, y, dist = queue.popleft()

            if x == n - 1 and y == n - 1:
                return dist

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] == 0:
                    grid[nx][ny] = 1
                    queue.append((nx, ny, dist + 1))

        return -1