class Solution:
    def oddCells(self, m: int, n: int, indices: list[list[int]]) -> int:
        rows_inc = [0] * m
        cols_inc = [0] * n

        for ri, ci in indices:
            rows_inc[ri] += 1
            cols_inc[ci] += 1

        odd_rows_count = 0
        for val in rows_inc:
            if val % 2 == 1:
                odd_rows_count += 1

        odd_cols_count = 0
        for val in cols_inc:
            if val % 2 == 1:
                odd_cols_count += 1

        even_rows_count = m - odd_rows_count
        even_cols_count = n - odd_cols_count

        # A cell (i, j) has an odd value if (rows_inc[i] + cols_inc[j]) is odd.
        # This happens if rows_inc[i] is odd and cols_inc[j] is even,
        # OR if rows_inc[i] is even and cols_inc[j] is odd.

        return (odd_rows_count * even_cols_count) + (even_rows_count * odd_cols_count)