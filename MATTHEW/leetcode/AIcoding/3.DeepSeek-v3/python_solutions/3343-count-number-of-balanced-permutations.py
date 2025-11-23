class Solution:
    def countBalancedPermutations(self, n: int) -> int:
        MOD = 10**9 + 7
        if n == 1:
            return 1
        dp = [0] * (n + 1)
        dp[1] = 1
        for i in range(2, n + 1):
            dp[i] = dp[i - 1] * (2 * i - 1) % MOD
        return dp[n]