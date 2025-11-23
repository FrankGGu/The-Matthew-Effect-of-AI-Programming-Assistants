class Solution:
    def getAverage(self, grid):
        from collections import deque
        m, n = len(grid), len(grid[0])
        result = [[0] * n for _ in range(m)]
        visited = [[False] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                if not visited[i][j]:
                    queue = deque()
                    queue.append((i, j))
                    visited[i][j] = True
                    total = grid[i][j]
                    count = 1
                    while queue:
                        x, y = queue.popleft()
                        for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                            nx, ny = x + dx, y + dy
                            if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny] and grid[nx][ny] == grid[i][j]:
                                visited[nx][ny] = True
                                queue.append((nx, ny))
                                total += grid[nx][ny]
                                count += 1
                    avg = total // count
                    for x in range(m):
                        for y in range(n):
                            if visited[x][y] and grid[x][y] == grid[i][j]:
                                result[x][y] = avg
        return result