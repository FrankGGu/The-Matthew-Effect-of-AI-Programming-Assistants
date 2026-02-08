class Solution:
    def peopleAwareOfSecret(self, n: int, delay: int, forget: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (n + 1)
        dp[1] = 1
        for i in range(2, n + 1):
            for j in range(max(1, i - forget + 1), i - delay + 1):
                dp[i] += dp[j]
                dp[i] %= MOD
        total = 0
        for i in range(max(1, n - forget + 1), n + 1):
            total += dp[i]
            total %= MOD
        return total