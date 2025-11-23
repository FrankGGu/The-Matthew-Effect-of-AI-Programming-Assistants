class Solution:
    def minimumTimeToBreakLocks(self, grid: List[List[int]]) -> int:
        from collections import deque

        m, n = len(grid), len(grid[0])
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def is_valid(x, y):
            return 0 <= x < m and 0 <= y < n

        def bfs():
            q = deque()
            visited = [[False for _ in range(n)] for _ in range(m)]
            time = 0
            for i in range(m):
                for j in range(n):
                    if grid[i][j] == 0:
                        q.append((i, j))
                        visited[i][j] = True
            if not q:
                return -1
            while q:
                level_size = len(q)
                for _ in range(level_size):
                    x, y = q.popleft()
                    for dx, dy in directions:
                        nx, ny = x + dx, y + dy
                        if is_valid(nx, ny) and not visited[nx][ny]:
                            if grid[nx][ny] == 1:
                                grid[nx][ny] = 0
                            visited[nx][ny] = True
                            q.append((nx, ny))
                time += 1
            return time - 1

        return bfs()