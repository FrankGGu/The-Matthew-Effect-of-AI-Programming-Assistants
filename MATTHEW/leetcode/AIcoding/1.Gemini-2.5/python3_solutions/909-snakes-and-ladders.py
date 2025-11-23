import collections

class Solution:
    def snakesAndLadders(self, board: list[list[int]]) -> int:
        n = len(board)
        target = n * n

        def get_coords(s: int) -> tuple[int, int]:
            r_from_bottom = (s - 1) // n
            row = n - 1 - r_from_bottom

            col_in_row = (s - 1) % n

            if r_from_bottom % 2 == 0:
                col = col_in_row
            else:
                col = n - 1 - col_in_row
            return row, col

        q = collections.deque()
        q.append((1, 0))
        visited = {1}

        while q:
            curr_s, moves = q.popleft()

            if curr_s == target:
                return moves

            for dice_roll in range(1, 7):
                next_s = curr_s + dice_roll
                if next_s > target:
                    continue

                r, c = get_coords(next_s)

                final_dest = next_s
                if board[r][c] != -1:
                    final_dest = board[r][c]

                if final_dest not in visited:
                    visited.add(final_dest)
                    q.append((final_dest, moves + 1))

        return -1