from typing import List

class Solution:
    def countSubmatrices(self, mat: List[List[int]]) -> int:
        R = len(mat)
        C = len(mat[0])

        total_submatrices = 0

        # current_row_heights[j] stores the number of consecutive ones ending at (current_row, j)
        # and extending upwards.
        current_row_heights = [0] * C

        for r in range(R):
            for c in range(C):
                if mat[r][c] == 1:
                    current_row_heights[c] += 1
                else:
                    current_row_heights[c] = 0

                # For the current cell (r, c), we count all submatrices of ones
                # that have (r, c) as their bottom-right corner.
                # We iterate leftwards from 'c' to '0'.
                # For each 'k' from 'c' down to '0', 'min_h' will store the minimum height
                # among the columns from 'k' to 'c' (inclusive) in the current row 'r'.
                # This 'min_h' represents the maximum possible height for a rectangle
                # of width (c - k + 1) ending at (r, c).
                # Such a rectangle can form 'min_h' sub-rectangles of width (c - k + 1)
                # and heights 1, 2, ..., min_h. We add these to the total count.

                min_h = current_row_heights[c]
                for k in range(c, -1, -1):
                    min_h = min(min_h, current_row_heights[k])
                    total_submatrices += min_h

        return total_submatrices