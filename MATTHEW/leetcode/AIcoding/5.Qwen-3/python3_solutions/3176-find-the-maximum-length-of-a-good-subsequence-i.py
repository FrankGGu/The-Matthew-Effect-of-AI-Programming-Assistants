class Solution:
    def maxLength(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[0] * (k + 1) for _ in range(n)]

        for i in range(n):
            if s[i] == 'a':
                for j in range(1, k + 1):
                    if i > 0:
                        dp[i][j] = dp[i - 1][j]
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + 1 if i > 0 else 1)
            else:
                for j in range(k + 1):
                    if i > 0:
                        dp[i][j] = dp[i - 1][j]

        return dp[n - 1][k]