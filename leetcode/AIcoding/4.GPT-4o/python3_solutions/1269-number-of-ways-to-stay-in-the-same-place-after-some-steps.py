class Solution:
    def numWays(self, steps: int, arrLen: int) -> int:
        mod = 10**9 + 7
        maxPos = min(steps, arrLen - 1)
        dp = [0] * (maxPos + 1)
        dp[0] = 1

        for _ in range(steps):
            new_dp = [0] * (maxPos + 1)
            for j in range(maxPos + 1):
                new_dp[j] = dp[j] % mod
                if j > 0:
                    new_dp[j] = (new_dp[j] + dp[j - 1]) % mod
                if j < maxPos:
                    new_dp[j] = (new_dp[j] + dp[j + 1]) % mod
            dp = new_dp

        return dp[0]