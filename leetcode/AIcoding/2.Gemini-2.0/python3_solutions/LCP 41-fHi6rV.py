class Solution:
    def flipChess(self, chessboard: List[str]) -> int:
        m, n = len(chessboard), len(chessboard[0])
        board = [list(row) for row in chessboard]

        def isValid(x, y):
            return 0 <= x < m and 0 <= y < n

        def check_direction(x, y, dx, dy, temp_board):
            stones = []
            nx, ny = x + dx, y + dy
            while isValid(nx, ny) and temp_board[nx][ny] == 'B':
                stones.append((nx, ny))
                nx, ny = nx + dx, ny + dy
            if isValid(nx, ny) and temp_board[nx][ny] == 'X':
                return stones
            else:
                return []

        def flip_stones(x, y, temp_board):
            flipped = 0
            directions = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
            for dx, dy in directions:
                stones_to_flip = check_direction(x, y, dx, dy, temp_board)
                for sx, sy in stones_to_flip:
                    temp_board[sx][sy] = 'X'
                    flipped += 1
            return flipped

        max_flipped = 0
        for i in range(m):
            for j in range(n):
                if board[i][j] == '.':
                    temp_board = [row[:] for row in board]
                    temp_board[i][j] = 'X'
                    max_flipped = max(max_flipped, flip_stones(i, j, temp_board))

        return max_flipped