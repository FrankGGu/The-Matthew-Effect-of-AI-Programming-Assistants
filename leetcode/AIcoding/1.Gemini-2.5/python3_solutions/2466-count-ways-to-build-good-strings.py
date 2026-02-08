class Solution:
    def countGoodStrings(self, low: int, high: int, zero: int, one: int) -> int:
        MOD = 10**9 + 7

        dp = [0] * (high + 1)
        dp[0] = 1

        for i in range(1, high + 1):
            if i - zero >= 0:
                dp[i] = (dp[i] + dp[i - zero]) % MOD
            if i - one >= 0:
                dp[i] = (dp[i] + dp[i - one]) % MOD

        total_good_strings = 0
        for i in range(low, high + 1):
            total_good_strings = (total_good_strings + dp[i]) % MOD

        return total_good_strings