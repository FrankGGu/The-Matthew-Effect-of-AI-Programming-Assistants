class Solution:
    def numberOfWays(self, num_people: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (num_people + 1)
        dp[0] = 1
        for i in range(2, num_people + 1, 2):
            for j in range(0, i - 1, 2):
                dp[i] += dp[j] * dp[i - 2 - j]
                dp[i] %= MOD
        return dp[num_people]