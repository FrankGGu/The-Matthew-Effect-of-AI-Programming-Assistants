class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:
        board = [[''] * 3 for _ in range(3)]

        for i, move in enumerate(moves):
            player = 'A' if i % 2 == 0 else 'B'
            board[move[0]][move[1]] = player

        for player in ['A', 'B']:
            if any(all(board[i][j] == player for j in range(3)) for i in range(3)) or \
               any(all(board[j][i] == player for j in range(3)) for i in range(3)) or \
               all(board[i][i] == player for i in range(3)) or \
               all(board[i][2 - i] == player for i in range(3)):
                return player

        return "Draw" if len(moves) == 9 else "Pending"