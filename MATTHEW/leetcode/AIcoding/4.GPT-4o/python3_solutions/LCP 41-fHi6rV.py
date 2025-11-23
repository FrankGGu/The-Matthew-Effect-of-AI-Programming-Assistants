class Solution:
    def flipChess(self, chessboard: List[str]) -> int:
        def count_flips(board):
            return sum(row.count('W') for row in board)

        max_flips = 0
        directions = [(1, 0), (0, 1), (1, 1), (1, -1)]

        for i in range(4):
            for j in range(4):
                if chessboard[i][j] == '.':
                    new_board = [list(row) for row in chessboard]
                    new_board[i][j] = 'W'
                    for di, dj in directions:
                        ni, nj = i + di, j + dj
                        while 0 <= ni < 4 and 0 <= nj < 4 and new_board[ni][nj] == 'B':
                            new_board[ni][nj] = 'W'
                            ni += di
                            nj += dj
                    max_flips = max(max_flips, count_flips(new_board))

        return max_flips