class Solution:
    def tictactoe(self, moves: List[List[int]]) -> str:
        n = 3
        rows = [0] * n
        cols = [0] * n
        diag = 0
        anti_diag = 0

        for i, (r, c) in enumerate(moves):
            player = 1 if i % 2 == 0 else -1
            rows[r] += player
            cols[c] += player
            if r == c:
                diag += player
            if r + c == n - 1:
                anti_diag += player

            if abs(rows[r]) == n or abs(cols[c]) == n or abs(diag) == n or abs(anti_diag) == n:
                return "A" if player == 1 else "B"

        return "Draw" if len(moves) == n * n else "Pending"