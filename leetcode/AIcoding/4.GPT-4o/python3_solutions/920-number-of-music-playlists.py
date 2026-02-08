class Solution:
    def countPlaylists(self, n: int, goal: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (goal + 1) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(1, goal + 1):
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (n - i + 1)) % MOD
                if i > k:
                    dp[i][j] = (dp[i][j] + dp[i][j - 1] * (i - k)) % MOD

        return dp[n][goal]