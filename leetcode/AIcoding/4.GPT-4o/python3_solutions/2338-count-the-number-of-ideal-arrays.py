class Solution:
    def idealArrays(self, n: int, maxValue: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (maxValue + 1)
        for i in range(1, maxValue + 1):
            dp[i] = pow(i, n, MOD)
        total = sum(dp) % MOD

        for i in range(1, maxValue + 1):
            for j in range(2 * i, maxValue + 1, i):
                dp[j] = (dp[j] - dp[i]) % MOD

        return total