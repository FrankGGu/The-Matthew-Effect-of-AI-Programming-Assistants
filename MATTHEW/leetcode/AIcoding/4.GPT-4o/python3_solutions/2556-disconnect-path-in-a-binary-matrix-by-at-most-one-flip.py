from collections import deque

class Solution:
    def canDisconnect(self, grid: List[List[int]]) -> bool:
        n, m = len(grid), len(grid[0])
        directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]

        def bfs(start, end):
            queue = deque([start])
            visited = set([start])
            while queue:
                x, y = queue.popleft()
                if (x, y) == end:
                    return True
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < m and (nx, ny) not in visited:
                        if grid[nx][ny] == 0:
                            visited.add((nx, ny))
                            queue.append((nx, ny))
            return False

        start = (0, 0)
        end = (n - 1, m - 1)

        if grid[0][0] == 1 and grid[n - 1][m - 1] == 1:
            return bfs(start, end)

        if grid[0][0] == 0 and grid[n - 1][m - 1] == 0:
            return bfs(start, end)

        for i in range(n):
            for j in range(m):
                if grid[i][j] == 0:
                    grid[i][j] = 1
                    if bfs(start, end):
                        return True
                    grid[i][j] = 0

        return False