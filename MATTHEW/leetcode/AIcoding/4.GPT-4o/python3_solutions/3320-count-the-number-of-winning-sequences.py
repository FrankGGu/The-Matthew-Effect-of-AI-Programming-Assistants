class Solution:
    def countWinningSequences(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            for j in range(1, min(k, i) + 1):
                dp[i] = (dp[i] + dp[i - j]) % MOD

        return dp[n]