class Solution:
    def numberOfWays(self, n: int, x: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        dp[0] = 1

        for a in range(1, n + 1):
            power = a ** x
            if power > n:
                break
            for i in range(n, power - 1, -1):
                dp[i] = (dp[i] + dp[i - power]) % MOD

        return dp[n] % MOD