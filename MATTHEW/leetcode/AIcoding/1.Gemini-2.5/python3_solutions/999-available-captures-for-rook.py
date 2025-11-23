class Solution:
    def numRookCaptures(self, board: list[list[str]]) -> int:
        r_row, r_col = -1, -1
        for r in range(8):
            for c in range(8):
                if board[r][c] == 'R':
                    r_row, r_col = r, c
                    break
            if r_row != -1:
                break

        captures = 0

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for dr, dc in directions:
            for step in range(1, 8):
                nr, nc = r_row + dr * step, r_col + dc * step

                if not (0 <= nr < 8 and 0 <= nc < 8):
                    break

                if board[nr][nc] == 'p':
                    captures += 1
                    break
                elif board[nr][nc] == 'B':
                    break

        return captures