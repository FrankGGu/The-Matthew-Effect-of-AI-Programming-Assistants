class Solution:
    def peopleAwareOfSecret(self, n: int, delay: int, forget: int) -> int:
        dp = [0] * (n + 1)
        dp[1] = 1
        MOD = 10**9 + 7

        for i in range(2, n + 1):
            dp[i] = (dp[i - 1] if i - 1 >= 1 else 0) % MOD
            if i - delay >= 1:
                dp[i] = (dp[i] + dp[i - delay]) % MOD
            if i - forget >= 1:
                dp[i] = (dp[i] - dp[i - forget] + MOD) % MOD

        return sum(dp[i] for i in range(n - forget + 1, n + 1)) % MOD