class Solution:
    def luckyNumbers (self, matrix: list[list[int]]) -> list[int]:
        m = len(matrix)
        n = len(matrix[0])

        row_mins = set()
        for i in range(m):
            row_mins.add(min(matrix[i]))

        col_maxs = set()
        for j in range(n):
            current_col_max = 0
            # Initialize with a value from the column or negative infinity
            # Since constraints are 1 <= matrix[i][j] <= 10^5, 0 is safe as a lower bound.
            # Or, initialize with matrix[0][j]
            current_col_max = matrix[0][j] 
            for i in range(m):
                current_col_max = max(current_col_max, matrix[i][j])
            col_maxs.add(current_col_max)

        return list(row_mins.intersection(col_maxs))