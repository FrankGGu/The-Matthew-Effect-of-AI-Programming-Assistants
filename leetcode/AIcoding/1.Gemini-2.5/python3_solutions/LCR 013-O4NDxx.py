class NumMatrix:

    def __init__(self, matrix: list[list[int]]):
        m = len(matrix)
        n = len(matrix[0]) if m > 0 else 0

        self.prefix_sum = [[0] * (n + 1) for _ in range(m + 1)]

        for r in range(m):
            for c in range(n):
                self.prefix_sum[r + 1][c + 1] = matrix[r][c] + self.prefix_sum[r][c + 1] + self.prefix_sum[r + 1][c] - self.prefix_sum[r][c]

    def sumRegion(self, row1: int, col1: int, row2: int, col2: int) -> int:
        # The sum of the rectangle (row1, col1) to (row2, col2) can be calculated as:
        # sum(0,0 to row2,col2) - sum(0,0 to row1-1,col2) - sum(0,0 to row2,col1-1) + sum(0,0 to row1-1,col1-1)

        # Adjusting for 1-based indexing of prefix_sum array:
        # (row2+1, col2+1) corresponds to sum(0,0 to row2,col2)
        # (row1, col2+1) corresponds to sum(0,0 to row1-1,col2)
        # (row2+1, col1) corresponds to sum(0,0 to row2,col1-1)
        # (row1, col1) corresponds to sum(0,0 to row1-1,col1-1)

        return self.prefix_sum[row2 + 1][col2 + 1] - self.prefix_sum[row1][col2 + 1] - self.prefix_sum[row2 + 1][col1] + self.prefix_sum[row1][col1]