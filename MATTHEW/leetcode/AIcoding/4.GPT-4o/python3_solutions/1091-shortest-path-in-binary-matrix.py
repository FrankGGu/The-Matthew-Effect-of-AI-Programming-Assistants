from collections import deque

class Solution:
    def shortestPathBinaryMatrix(self, grid):
        if grid[0][0] == 1 or grid[-1][-1] == 1:
            return -1

        n = len(grid)
        directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        queue = deque([(0, 0, 1)])  # (row, col, path_length)
        visited = set((0, 0))

        while queue:
            x, y, length = queue.popleft()
            if x == n - 1 and y == n - 1:
                return length

            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and (nx, ny) not in visited and grid[nx][ny] == 0:
                    visited.add((nx, ny))
                    queue.append((nx, ny, length + 1))

        return -1