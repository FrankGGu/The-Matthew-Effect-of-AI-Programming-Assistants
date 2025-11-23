class Solution:
    def hasValidPath(self, grid: List[List[int]]) -> bool:
        from collections import deque

        m, n = len(grid), len(grid[0])
        visited = [[False] * n for _ in range(m)]
        queue = deque()
        queue.append((0, 0))
        visited[0][0] = True
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            x, y = queue.popleft()
            if x == m - 1 and y == n - 1:
                return True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    if (grid[x][y] + grid[nx][ny]) % 2 == 0:
                        visited[nx][ny] = True
                        queue.append((nx, ny))
        return False