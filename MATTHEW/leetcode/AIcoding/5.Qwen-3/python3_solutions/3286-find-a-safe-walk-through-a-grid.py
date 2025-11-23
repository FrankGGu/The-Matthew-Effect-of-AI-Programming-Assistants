class Solution:
    def orient(self, grid, k):
        from collections import deque
        m, n = len(grid), len(grid[0])
        dist = [[float('inf')] * n for _ in range(m)]
        q = deque()
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 0:
                    dist[i][j] = 0
                    q.append((i, j))
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        while q:
            x, y = q.popleft()
            for dx, dy in dirs:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    if dist[nx][ny] > dist[x][y] + 1:
                        dist[nx][ny] = dist[x][y] + 1
                        q.append((nx, ny))
        return dist[m-1][n-1] >= k