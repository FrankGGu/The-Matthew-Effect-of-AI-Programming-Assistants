class Solution:
    def _check_win(self, board, player_symbol):
        # Check rows
        for r in range(3):
            if all(board[r][c] == player_symbol for c in range(3)):
                return True
        # Check columns
        for c in range(3):
            if all(board[r][c] == player_symbol for r in range(3)):
                return True
        # Check main diagonal
        if all(board[i][i] == player_symbol for i in range(3)):
            return True
        # Check anti-diagonal
        if all(board[i][2 - i] == player_symbol for i in range(3)):
            return True
        return False

    def tictactoe(self, moves: list[list[int]]) -> str:
        board = [[''] * 3 for _ in range(3)]

        for i, (r, c) in enumerate(moves):
            current_player_symbol = 'X' if i % 2 == 0 else 'O'
            board[r][c] = current_player_symbol

            if i >= 4:  # A winner can only be determined after at least 5 moves
                if self._check_win(board, current_player_symbol):
                    return "A" if current_player_symbol == 'X' else "B"

        if len(moves) == 9:
            return "Draw"
        else:
            return "Pending"