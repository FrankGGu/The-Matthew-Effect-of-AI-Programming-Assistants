class Solution:
    def numTilings(self, N: int) -> int:
        if N == 0:
            return 1
        if N == 1:
            return 1
        if N == 2:
            return 2

        MOD = 10**9 + 7
        dp = [0] * (N + 1)
        dp[0], dp[1], dp[2] = 1, 1, 2

        for i in range(3, N + 1):
            dp[i] = (dp[i - 1] + dp[i - 2] * 2) % MOD

        return dp[N]