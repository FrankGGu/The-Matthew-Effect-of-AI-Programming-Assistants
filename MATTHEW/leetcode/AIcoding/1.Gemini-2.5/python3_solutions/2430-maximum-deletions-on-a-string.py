class Solution:
    def deleteString(self, s: str) -> int:
        n = len(s)

        dp = [0] * (n + 1)

        lcp = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(n - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if s[i] == s[j]:
                    lcp[i][j] = 1 + lcp[i+1][j+1]
                else:
                    lcp[i][j] = 0

        for i in range(n - 1, -1, -1):
            dp[i] = 1

            for L in range(1, (n - i) // 2 + 1):
                if lcp[i][i+L] >= L:
                    dp[i] = max(dp[i], 1 + dp[i+L])

        return dp[0]