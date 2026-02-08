class Solution:
    def validTicTacToe(self, board: List[str]) -> bool:
        x_count = sum(row.count('X') for row in board)
        o_count = sum(row.count('O') for row in board)

        if o_count > x_count or x_count > o_count + 1:
            return False

        x_win = any(all(cell == 'X' for cell in line) for line in (board + [''.join(row) for row in zip(*board))] + [board[i][i] for i in range(3)] + [board[i][2 - i] for i in range(3)]))
        o_win = any(all(cell == 'O' for cell in line) for line in (board + [''.join(row) for row in zip(*board))] + [board[i][i] for i in range(3)] + [board[i][2 - i] for i in range(3)]))

        if x_win and o_win:
            return False
        if x_win and x_count != o_count + 1:
            return False
        if o_win and x_count != o_count:
            return False

        return True