import collections

class Solution:
    def maximumRows(self, mat: list[list[int]], numSelect: int) -> int:
        m = len(mat)
        n = len(mat[0])

        # Pre-calculate a bitmask for each row
        # The j-th bit is set if mat[i][j] is 1
        row_bitmasks = []
        for i in range(m):
            current_row_mask = 0
            for j in range(n):
                if mat[i][j] == 1:
                    current_row_mask |= (1 << j)
            row_bitmasks.append(current_row_mask)

        max_covered_rows = 0

        # Iterate through all possible combinations of column selections using a bitmask
        # A bitmask `selected_columns_mask` represents the chosen columns.
        # If the j-th bit is set, column j is selected.
        for selected_columns_mask in range(1 << n):
            # Check if the number of selected columns matches numSelect
            # bin(selected_columns_mask).count('1') counts the set bits
            if bin(selected_columns_mask).count('1') != numSelect:
                continue

            current_covered_rows = 0
            # For each row, check if it is covered by the current column selection
            for row_mask in row_bitmasks:
                # A row is covered if all '1's in that row are within the selected columns.
                # This means that if we bitwise AND the row_mask with the selected_columns_mask,
                # the result should be equal to the original row_mask.
                # (row_mask & selected_columns_mask) == row_mask
                if (row_mask & selected_columns_mask) == row_mask:
                    current_covered_rows += 1

            max_covered_rows = max(max_covered_rows, current_covered_rows)

        return max_covered_rows