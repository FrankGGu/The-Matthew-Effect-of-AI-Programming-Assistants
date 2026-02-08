class Solution:
    def numWays(self, steps: int, arrLen: int) -> int:
        mod = 10**9 + 7
        max_pos = min(arrLen - 1, steps)
        dp = [0] * (max_pos + 1)
        dp[0] = 1

        for step in range(steps):
            new_dp = [0] * (max_pos + 1)
            for pos in range(max_pos + 1):
                new_dp[pos] = dp[pos] % mod
                if pos > 0:
                    new_dp[pos] = (new_dp[pos] + dp[pos - 1]) % mod
                if pos < max_pos:
                    new_dp[pos] = (new_dp[pos] + dp[pos + 1]) % mod
            dp = new_dp

        return dp[0]