class Solution:
    def findPeakII(self, matrix: List[List[int]]) -> List[int]:
        rows, cols = len(matrix), len(matrix[0])
        left, right = 0, cols - 1

        while left <= right:
            mid_col = (left + right) // 2
            max_row = 0
            for i in range(rows):
                if matrix[i][mid_col] > matrix[max_row][mid_col]:
                    max_row = i
            if mid_col == 0:
                return [max_row, mid_col]
            if matrix[max_row][mid_col] > matrix[max_row][mid_col - 1]:
                left = mid_col + 1
            else:
                right = mid_col - 1

        return [0, 0]