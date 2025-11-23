class Solution:
    def findPeakGrid(self, mat: list[list[int]]) -> list[int]:
        m = len(mat)
        n = len(mat[0])

        low_col = 0
        high_col = n - 1

        while low_col <= high_col:
            mid_col = low_col + (high_col - low_col) // 2

            max_row_in_mid_col = 0
            for r in range(m):
                if mat[r][mid_col] > mat[max_row_in_mid_col][mid_col]:
                    max_row_in_mid_col = r

            current_val = mat[max_row_in_mid_col][mid_col]

            left_val = -1
            if mid_col > 0:
                left_val = mat[max_row_in_mid_col][mid_col - 1]

            right_val = -1
            if mid_col < n - 1:
                right_val = mat[max_row_in_mid_col][mid_col + 1]

            if current_val > left_val and current_val > right_val:
                return [max_row_in_mid_col, mid_col]
            elif current_val < left_val:
                high_col = mid_col - 1
            else: # current_val < right_val
                low_col = mid_col + 1

        return [-1, -1]