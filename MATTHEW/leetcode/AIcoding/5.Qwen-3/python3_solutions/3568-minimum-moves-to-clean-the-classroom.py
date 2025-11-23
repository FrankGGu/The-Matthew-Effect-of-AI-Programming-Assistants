class Solution:
    def minMoves(self, m: List[List[int]]) -> int:
        from collections import deque

        rows, cols = len(m), len(m[0])
        q = deque()
        visited = [[False] * cols for _ in range(rows)]

        for i in range(rows):
            for j in range(cols):
                if m[i][j] == 1:
                    q.append((i, j))
                    visited[i][j] = True

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        moves = 0

        while q:
            for _ in range(len(q)):
                x, y = q.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < rows and 0 <= ny < cols and not visited[nx][ny]:
                        visited[nx][ny] = True
                        q.append((nx, ny))
            moves += 1

        return moves - 1