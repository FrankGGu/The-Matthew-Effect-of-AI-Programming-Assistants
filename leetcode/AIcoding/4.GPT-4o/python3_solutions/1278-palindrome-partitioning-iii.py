class Solution:
    def palindromePartition(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        cost = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(i, n):
                if s[i] != s[j]:
                    cost[i][j] = 1
                if i + 1 <= j - 1:
                    cost[i][j] += cost[i + 1][j - 1]

        for i in range(n + 1):
            dp[i][0] = float('inf')

        dp[0][0] = 0

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                for l in range(i):
                    dp[i][j] = min(dp[i][j], dp[l][j - 1] + cost[l][i - 1])

        return dp[n][k]