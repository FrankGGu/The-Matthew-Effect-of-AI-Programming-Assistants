class Solution:
    def champagneTower(self, poured: int, query_row: int, query_col: int) -> int:
        dp = [[0.0] * (i + 1) for i in range(query_row + 2)]
        dp[0][0] = poured
        for row in range(query_row + 1):
            for col in range(row + 1):
                if dp[row][col] > 1:
                    overflow = dp[row][col] - 1
                    dp[row][col] = 1
                    dp[row + 1][col] += overflow / 2
                    dp[row + 1][col + 1] += overflow / 2
        return int(dp[query_row][query_col])