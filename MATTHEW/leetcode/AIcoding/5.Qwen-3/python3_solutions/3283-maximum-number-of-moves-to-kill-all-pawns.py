class Solution:
    def maxMoves(self, grid: List[List[int]]) -> int:
        from collections import deque

        m, n = len(grid), len(grid[0])
        visited = [[False] * n for _ in range(m)]
        q = deque()

        for i in range(m):
            if grid[i][0] == 1:
                q.append((i, 0))
                visited[i][0] = True

        directions = [(-1, 1), (0, 1), (1, 1)]
        moves = 0

        while q:
            for _ in range(len(q)):
                x, y = q.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny] and grid[nx][ny] == 1:
                        visited[nx][ny] = True
                        q.append((nx, ny))
            moves += 1

        return moves - 1