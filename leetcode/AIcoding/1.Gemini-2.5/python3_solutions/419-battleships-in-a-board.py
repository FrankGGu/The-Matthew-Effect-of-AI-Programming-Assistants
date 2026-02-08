class Solution:
    def countBattleships(self, board: list[list[str]]) -> int:
        if not board or not board[0]:
            return 0

        rows = len(board)
        cols = len(board[0])
        battleship_count = 0

        for r in range(rows):
            for c in range(cols):
                if board[r][c] == 'X':
                    # Check if this 'X' is the top-most and left-most part of a battleship
                    # If its top neighbor is 'X', it's part of a vertical ship already counted (or will be from above)
                    # If its left neighbor is 'X', it's part of a horizontal ship already counted (or will be from left)
                    is_top_part = (r == 0) or (board[r-1][c] == '.')
                    is_left_part = (c == 0) or (board[r][c-1] == '.')

                    if is_top_part and is_left_part:
                        battleship_count += 1

        return battleship_count