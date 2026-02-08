from typing import List

class Solution:
    def maxMoves(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        reachable_cells_in_current_col = set(range(m))

        max_moves = 0

        for c in range(n - 1):
            reachable_cells_in_next_col = set()
            moved_in_this_column = False

            for r in reachable_cells_in_current_col:
                current_val = grid[r][c]

                # Check move to (r-1, c+1)
                if r > 0 and grid[r-1][c+1] > current_val:
                    reachable_cells_in_next_col.add(r-1)
                    moved_in_this_column = True

                # Check move to (r, c+1)
                if grid[r][c+1] > current_val:
                    reachable_cells_in_next_col.add(r)
                    moved_in_this_column = True

                # Check move to (r+1, c+1)
                if r < m - 1 and grid[r+1][c+1] > current_val:
                    reachable_cells_in_next_col.add(r+1)
                    moved_in_this_column = True

            if not moved_in_this_column:
                break

            max_moves = c + 1

            reachable_cells_in_current_col = reachable_cells_in_next_col

        return max_moves