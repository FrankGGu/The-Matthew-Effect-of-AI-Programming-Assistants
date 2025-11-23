class Solution:
    def goodSubsetofBinaryMatrix(self, grid: list[list[int]]) -> list[int]:
        m = len(grid)
        n = len(grid[0])

        # A non-empty subset of rows is good if the bitwise OR of all rows in the subset
        # is a row of all zeros.
        # Let the subset be {r_1, r_2, ..., r_k}.
        # The condition is r_1 | r_2 | ... | r_k = [0, 0, ..., 0].
        # For any column j, this means r_1[j] | r_2[j] | ... | r_k[j] = 0.
        # Since grid[i][j] can only be 0 or 1, the only way for a bitwise OR of multiple
        # bits to be 0 is if all those bits are 0.
        # Therefore, for each column j, it must be that r_1[j] = 0, r_2[j] = 0, ..., r_k[j] = 0.
        # Since this must hold for all columns j from 0 to n-1, it implies that
        # every row in the subset must be the all-zero row:
        # r_1 = [0, 0, ..., 0]
        # r_2 = [0, 0, ..., 0]
        # ...
        # r_k = [0, 0, ..., 0]

        # Thus, a good subset can only be formed if at least one row in the matrix is
        # the all-zero row. If such a row exists, say at index `i`, then the subset
        # containing only `grid[i]` is a good subset (its OR is `grid[i]` itself, which is all zeros).
        # We need to return the indices of any such good subset. The simplest is a single-row subset.

        for i in range(m):
            is_zero_row = True
            for j in range(n):
                if grid[i][j] == 1:
                    is_zero_row = False
                    break
            if is_zero_row:
                return [i]

        # If no row consisting entirely of zeros is found, then no good subset can be formed.
        return []