class Solution:
    def numPermsDISequence(self, S: str) -> int:
        MOD = 10**9 + 7
        n = len(S)
        dp = [[0] * (n + 1) for _ in range(n + 1)]
        for j in range(n + 1):
            dp[0][j] = 1

        for i in range(1, n + 1):
            for j in range(0, n - i + 1):
                if S[i - 1] == 'D':
                    dp[i][j] = (dp[i - 1][j + 1] + dp[i][j - 1]) % MOD if j > 0 else dp[i - 1][j + 1] % MOD
                else:
                    dp[i][j] = (dp[i - 1][j] + dp[i][j - 1]) % MOD if j > 0 else dp[i - 1][j] % MOD

        return dp[n][0] % MOD