class Solution:
    def palindromePartition(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0
        cost = [[0] * n for _ in range(n)]
        for i in range(n - 1, -1, -1):
            for j in range(i + 1, n):
                cost[i][j] = cost[i + 1][j - 1] + (1 if s[i] != s[j] else 0)

        for i in range(1, n + 1):
            for j in range(1, min(i, k) + 1):
                for l in range(1, i + 1):
                    dp[i][j] = min(dp[i][j], dp[i - l][j - 1] + cost[i - l][i - 1])

        return dp[n][k]