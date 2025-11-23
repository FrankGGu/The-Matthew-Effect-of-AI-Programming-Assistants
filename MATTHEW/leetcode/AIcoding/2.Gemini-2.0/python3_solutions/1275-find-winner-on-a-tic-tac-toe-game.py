class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:
        n = 3
        board = [['' for _ in range(n)] for _ in range(n)]

        for i in range(len(moves)):
            row, col = moves[i]
            if i % 2 == 0:
                board[row][col] = 'A'
            else:
                board[row][col] = 'B'

        def check_winner(player):
            for i in range(n):
                if all(board[i][j] == player for j in range(n)):
                    return True
                if all(board[j][i] == player for j in range(n)):
                    return True
            if all(board[i][i] == player for i in range(n)):
                return True
            if all(board[i][n - 1 - i] == player for i in range(n)):
                return True
            return False

        if check_winner('A'):
            return "A"
        if check_winner('B'):
            return "B"

        if len(moves) == n * n:
            return "Draw"
        else:
            return "Pending"