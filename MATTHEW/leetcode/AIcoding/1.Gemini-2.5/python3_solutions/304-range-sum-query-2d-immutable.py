class NumMatrix:

    def __init__(self, matrix: list[list[int]]):
        if not matrix or not matrix[0]:
            self.dp = []
            return

        m, n = len(matrix), len(matrix[0])
        self.dp = [[0] * (n + 1) for _ in range(m + 1)]

        for r in range(m):
            for c in range(n):
                self.dp[r + 1][c + 1] = matrix[r][c] + self.dp[r][c + 1] + self.dp[r + 1][c] - self.dp[r][c]

    def sumRegion(self, row1: int, col1: int, row2: int, col2: int) -> int:
        if not self.dp:
            return 0

        # Add 1 to coordinates because dp array is 1-indexed for convenience
        # dp[r][c] stores the sum of the rectangle from (0,0) to (r-1, c-1)
        return self.dp[row2 + 1][col2 + 1] - self.dp[row1][col2 + 1] - self.dp[row2 + 1][col1] + self.dp[row1][col1]