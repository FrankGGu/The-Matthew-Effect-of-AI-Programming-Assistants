class Solution:
    def flipChess(self, chessboard: List[str]) -> int:
        directions = [(-1, -1), (-1, 0), (-1, 1),
                      (0, -1),          (0, 1),
                      (1, -1),  (1, 0), (1, 1)]
        m, n = len(chessboard), len(chessboard[0])

        def bfs(i, j):
            board = [list(row) for row in chessboard]
            from collections import deque
            q = deque([(i, j)])
            board[i][j] = 'X'
            count = 0
            while q:
                x, y = q.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    path = []
                    while 0 <= nx < m and 0 <= ny < n and board[nx][ny] == 'O':
                        path.append((nx, ny))
                        nx += dx
                        ny += dy
                    if 0 <= nx < m and 0 <= ny < n and board[nx][ny] == 'X' and path:
                        for px, py in path:
                            board[px][py] = 'X'
                            q.append((px, py))
                        count += len(path)
            return count

        res = 0
        for i in range(m):
            for j in range(n):
                if chessboard[i][j] == '.':
                    res = max(res, bfs(i, j))
        return res