class Solution:
    def minimumFlips(self, grid: list[list[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        flips = 0

        for r in range(rows):
            for c in range(cols):
                sym_r = rows - 1 - r
                sym_c = cols - 1 - c

                # To avoid double counting, we only consider a pair (r, c) and (sym_r, sym_c)
                # if (r, c) comes "before" (sym_r, sym_c) in lexicographical order.
                # If r < sym_r, then (r, c) is in the "first half" rows.
                # If r == sym_r, then (r, c) is in the "middle row" (if rows is odd),
                # and we only consider the "first half" columns of this middle row.

                if r < sym_r:
                    if grid[r][c] != grid[sym_r][sym_c]:
                        flips += 1
                elif r == sym_r: # This is the middle row (if rows is odd)
                    if c < sym_c: # This is the first half of columns in the middle row
                        if grid[r][c] != grid[sym_r][sym_c]:
                            flips += 1
                    # If c == sym_c, it's the very center element (if cols is odd).
                    # This element is its own symmetric counterpart and does not need
                    # to be flipped to match another element. So, no flip is counted.

        return flips