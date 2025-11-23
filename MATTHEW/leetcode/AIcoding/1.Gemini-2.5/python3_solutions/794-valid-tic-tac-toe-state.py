class Solution:
    def isValidTicTacToeState(self, board: list[str]) -> bool:
        x_count = 0
        o_count = 0
        for r in range(3):
            for c in range(3):
                if board[r][c] == 'X':
                    x_count += 1
                elif board[r][c] == 'O':
                    o_count += 1

        if not (x_count == o_count or x_count == o_count + 1):
            return False

        def check_win(player):
            for i in range(3):
                if all(board[i][j] == player for j in range(3)):
                    return True
                if all(board[j][i] == player for j in range(3)):
                    return True
            if all(board[i][i] == player for i in range(3)):
                return True
            if all(board[i][2 - i] == player for i in range(3)):
                return True
            return False

        x_wins = check_win('X')
        o_wins = check_win('O')

        if x_wins and o_wins:
            return False

        if x_wins and x_count != o_count + 1:
            return False

        if o_wins and x_count != o_count:
            return False

        return True