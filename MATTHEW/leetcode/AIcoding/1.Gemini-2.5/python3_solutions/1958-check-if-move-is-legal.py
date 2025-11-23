class Solution:
    def isLegalMove(self, board: List[List[str]], rMove: int, cMove: int, color: str) -> bool:
        R, C = len(board), len(board[0])

        if board[rMove][cMove] != '.':
            return False

        opposite_color = 'W' if color == 'B' else 'B'

        directions = [
            (0, 1), (0, -1),  # Horizontal
            (1, 0), (-1, 0),  # Vertical
            (1, 1), (1, -1),  # Diagonal
            (-1, 1), (-1, -1) # Diagonal
        ]

        def check_direction(r, c, dr, dc):
            r_curr, c_curr = r + dr, c + dc
            count_opposite = 0

            while 0 <= r_curr < R and 0 <= c_curr < C:
                current_cell_color = board[r_curr][c_curr]

                if current_cell_color == opposite_color:
                    count_opposite += 1
                    r_curr += dr
                    c_curr += dc
                elif current_cell_color == color:
                    return count_opposite >= 1
                else: # current_cell_color == '.'
                    return False 

            return False

        for dr, dc in directions:
            if check_direction(rMove, cMove, dr, dc):
                return True

        return False