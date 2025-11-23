import math

class Solution:
    def maxScore(self, grid: list[list[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        dp = [[0] * n for _ in range(m)]
        max_score = -math.inf

        for i in range(m):
            for j in range(n):
                current_min_prefix_val = grid[i][j]
                min_val_for_score_calculation = math.inf

                if i > 0:
                    current_min_prefix_val = min(current_min_prefix_val, dp[i-1][j])
                    min_val_for_score_calculation = min(min_val_for_score_calculation, dp[i-1][j])

                if j > 0:
                    current_min_prefix_val = min(current_min_prefix_val, dp[i][j-1])
                    min_val_for_score_calculation = min(min_val_for_score_calculation, dp[i][j-1])

                dp[i][j] = current_min_prefix_val

                if min_val_for_score_calculation != math.inf:
                    max_score = max(max_score, grid[i][j] - min_val_for_score_calculation)

        return int(max_score)