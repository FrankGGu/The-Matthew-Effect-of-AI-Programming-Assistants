class Solution:
    def numberOfWays(self, n: int, x: int) -> int:
        MOD = 10**9 + 7

        powers = []
        k = 1
        while True:
            power_val = k ** x
            if power_val > n:
                break
            powers.append(power_val)
            k += 1

        dp = [0] * (n + 1)
        dp[0] = 1

        for p in powers:
            for j in range(n, p - 1, -1):
                dp[j] = (dp[j] + dp[j - p]) % MOD

        return dp[n]