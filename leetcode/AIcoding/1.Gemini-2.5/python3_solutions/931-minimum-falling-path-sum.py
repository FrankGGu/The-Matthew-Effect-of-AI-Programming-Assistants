import math

class Solution:
    def minFallingPathSum(self, matrix: list[list[int]]) -> int:
        n = len(matrix)
        if n == 1:
            return min(matrix[0])

        dp = list(matrix[0])

        for i in range(1, n):
            new_dp = [0] * n
            for j in range(n):
                current_val = matrix[i][j]

                min_prev_row_sum = dp[j] # Straight down
                if j > 0:
                    min_prev_row_sum = min(min_prev_row_sum, dp[j-1]) # Diagonal left
                if j < n - 1:
                    min_prev_row_sum = min(min_prev_row_sum, dp[j+1]) # Diagonal right

                new_dp[j] = current_val + min_prev_row_sum
            dp = new_dp

        return min(dp)