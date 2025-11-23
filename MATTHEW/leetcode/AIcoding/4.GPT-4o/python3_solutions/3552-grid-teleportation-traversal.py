class Solution:
    def minTimeToTeleport(self, grid: List[List[int]]) -> int:
        n, m = len(grid), len(grid[0])
        teleporters = []
        for i in range(n):
            for j in range(m):
                if grid[i][j] == 1:
                    teleporters.append((i, j))

        from collections import deque
        queue = deque([(0, 0, 0)])  # (x, y, steps)
        visited = set()
        visited.add((0, 0))

        while queue:
            x, y, steps = queue.popleft()
            if x == n - 1 and y == m - 1:
                return steps
            for dx, dy in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < m and (nx, ny) not in visited:
                    visited.add((nx, ny))
                    queue.append((nx, ny, steps + 1))
            if grid[x][y] == 1:
                for tx, ty in teleporters:
                    if (tx, ty) != (x, y) and (tx, ty) not in visited:
                        visited.add((tx, ty))
                        queue.append((tx, ty, steps + 1))

        return -1