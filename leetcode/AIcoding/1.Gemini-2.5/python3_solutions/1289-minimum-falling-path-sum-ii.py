import math

class Solution:
    def minFallingPathSum(self, grid: list[list[int]]) -> int:
        n = len(grid)

        if n == 1:
            return grid[0][0]

        dp = list(grid[0])

        for r in range(1, n):
            # Find the two smallest values and their indices from the previous row's dp
            min1_val = math.inf
            min1_idx = -1
            min2_val = math.inf

            for c in range(n):
                if dp[c] < min1_val:
                    min2_val = min1_val
                    min1_val = dp[c]
                    min1_idx = c
                elif dp[c] < min2_val:
                    min2_val = dp[c]

            next_dp = [0] * n
            for c in range(n):
                if c == min1_idx:
                    next_dp[c] = grid[r][c] + min2_val
                else:
                    next_dp[c] = grid[r][c] + min1_val
            dp = next_dp

        return min(dp)