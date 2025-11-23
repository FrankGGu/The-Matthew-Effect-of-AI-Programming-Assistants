class Solution:
    def kInversePairs(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (k + 1)
        dp[0] = 1
        for i in range(1, n + 1):
            new_dp = [0] * (k + 1)
            for j in range(k + 1):
                for m in range(min(i - 1, j) + 1):
                    new_dp[j] += dp[j - m]
                    new_dp[j] %= MOD
            dp = new_dp
        return dp[k]