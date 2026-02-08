class Solution:
    def numRollsToTarget(self, d: int, f: int, target: int) -> int:
        MOD = 10**9 + 7

        dp = [0] * (target + 1)
        dp[0] = 1

        for i in range(1, d + 1):
            next_dp = [0] * (target + 1)
            for j in range(1, target + 1):
                for k in range(1, f + 1):
                    if j - k >= 0:
                        next_dp[j] = (next_dp[j] + dp[j - k]) % MOD
            dp = next_dp

        return dp[target]