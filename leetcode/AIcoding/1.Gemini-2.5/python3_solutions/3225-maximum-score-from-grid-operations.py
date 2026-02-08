import collections

class Solution:
    def maxScore(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        # max_row_val[r] stores the maximum score found so far for any path ending in row r
        # from a cell with a value strictly less than the current cell's value.
        max_row_val = [0] * m
        # max_col_val[c] stores the maximum score found so far for any path ending in column c
        # from a cell with a value strictly less than the current cell's value.
        max_col_val = [0] * n

        # Collect all cells with their values and coordinates
        cells = []
        for r in range(m):
            for c in range(n):
                cells.append((grid[r][c], r, c))

        # Sort cells primarily by their value in ascending order.
        # This allows processing cells in increasing order of their values,
        # which is crucial for the dynamic programming approach.
        cells.sort()

        max_overall_score = 0

        i = 0
        while i < len(cells):
            current_val = cells[i][0]

            # group_updates will store (r, c, calculated_dp_score) for all cells
            # that have the current_val. This is necessary because updates to
            # max_row_val and max_col_val should only reflect scores from cells
            # with values strictly less than current_val.
            # If we update max_row_val/max_col_val immediately, a cell (r,c)
            # might use a score from another cell (r, c_prime) or (r_prime, c)
            # that has the *same* current_val, which violates the strict inequality condition.
            group_updates = [] 

            j = i
            while j < len(cells) and cells[j][0] == current_val:
                val, r, c = cells[j]

                # The score for a path ending at (r, c) is 1 (for the cell itself)
                # plus the maximum score of a path ending at a previous valid cell
                # in the same row or same column.
                # If no such previous cell exists (i.e., max_row_val[r] and max_col_val[c] are 0),
                # the score for this cell is 1.
                current_dp_score = 1 + max(max_row_val[r], max_col_val[c])

                group_updates.append((r, c, current_dp_score))

                j += 1

            # After calculating dp scores for all cells in the current value group,
            # update the max_row_val and max_col_val arrays.
            # This ensures that these arrays only reflect scores from cells with
            # values strictly less than the current_val when they are used in the next iteration.
            for r, c, dp_score in group_updates:
                max_row_val[r] = max(max_row_val[r], dp_score)
                max_col_val[c] = max(max_col_val[c], dp_score)
                max_overall_score = max(max_overall_score, dp_score)

            # Move to the next group of distinct values
            i = j

        return max_overall_score