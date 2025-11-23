class Solution:
    def numWays(self, n: int, k: int) -> int:
        if n == 1:
            return k
        if k < 2:
            return 0
        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        dp[1] = k
        dp[2] = k * (k - 1) % MOD
        for i in range(3, n + 1):
            dp[i] = (dp[i - 1] * (k - 1) + dp[i - 2] * (k - 1)) % MOD
        return dp[n]