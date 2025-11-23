class Solution:
    def stoneGameV(self, stoneValue: List[int]) -> int:
        n = len(stoneValue)
        dp = [[0] * n for _ in range(n)]

        for length in range(1, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                total = sum(stoneValue[i:j + 1])
                for k in range(i, j):
                    left = sum(stoneValue[i:k + 1])
                    right = total - left
                    if left > right:
                        dp[i][j] = max(dp[i][j], dp[i][k] + right)
                    elif left < right:
                        dp[i][j] = max(dp[i][j], dp[k + 1][j] + left)
                    else:
                        dp[i][j] = max(dp[i][j], dp[i][k] + left, dp[k + 1][j] + right)

        return dp[0][n - 1]