class Solution:
    def stoneGameV(self, stoneValue: str) -> int:
        n = len(stoneValue)
        s = [int(c) for c in stoneValue]
        dp = [[0] * n for _ in range(n)]
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + s[i]

        for l in range(1, n + 1):
            for i in range(n - l + 1):
                j = i + l - 1
                total = prefix[j + 1] - prefix[i]
                for k in range(i, j):
                    left = prefix[k + 1] - prefix[i]
                    right = total - left
                    if left < right:
                        dp[i][j] = max(dp[i][j], dp[i][k] + left)
                    elif left > right:
                        dp[i][j] = max(dp[i][j], dp[k + 1][j] + right)
                    else:
                        dp[i][j] = max(dp[i][j], dp[i][k] + left)
        return dp[0][n - 1]