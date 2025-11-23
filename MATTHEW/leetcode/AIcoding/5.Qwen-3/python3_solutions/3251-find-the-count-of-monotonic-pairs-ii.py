class Solution:
    def countMonotonicPairs(self, n: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        for i in range(1, n + 1):
            dp[i] = (dp[i - 1] + i) % MOD
        return dp[n]