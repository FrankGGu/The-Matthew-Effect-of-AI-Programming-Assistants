class Solution:
    def selectKDisjointSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[0] * (k + 1) for _ in range(n + 1)]
        last = {}

        for i in range(1, n + 1):
            for j in range(k, 0, -1):
                dp[i][j] = dp[i - 1][j]
                if s[i - 1] not in last:
                    dp[i][j] = max(dp[i][j], 1 + dp[i - 1][j - 1])
                else:
                    dp[i][j] = max(dp[i][j], dp[last[s[i - 1]]][j] + 1)
            last[s[i - 1]] = i - 1

        return dp[n][k]