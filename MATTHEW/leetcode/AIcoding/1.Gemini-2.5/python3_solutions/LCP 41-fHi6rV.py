from typing import List

class Solution:
    def flipChess(self, board: List[str]) -> int:
        m = len(board)
        n = len(board[0])

        max_flips = 0

        dr = [-1, -1, -1, 0, 0, 1, 1, 1]
        dc = [-1, 0, 1, -1, 1, -1, 0, 1]

        def calculate_flips_for_position(r_start, c_start):
            current_move_flips = 0

            for i in range(8):
                flips_in_direction = 0
                curr_r, curr_c = r_start + dr[i], c_start + dc[i]
                found_own_piece = False

                while 0 <= curr_r < m and 0 <= curr_c < n:
                    if board[curr_r][curr_c] == 'W':
                        flips_in_direction += 1
                    elif board[curr_r][curr_c] == 'B':
                        found_own_piece = True
                        break
                    else:
                        break

                    curr_r += dr[i]
                    curr_c += dc[i]

                if found_own_piece and flips_in_direction > 0:
                    current_move_flips += flips_in_direction

            return current_move_flips

        for r in range(m):
            for c in range(n):
                if board[r][c] == '.':
                    flips = calculate_flips_for_position(r, c)
                    max_flips = max(max_flips, flips)

        return max_flips