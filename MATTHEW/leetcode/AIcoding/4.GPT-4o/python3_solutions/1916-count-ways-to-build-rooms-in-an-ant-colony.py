class Solution:
    def countWays(self, prevRoom: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(prevRoom)

        if n == 1:
            return 1

        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            dp[i] = dp[i - 1] * (i + 1) % MOD

        total_ways = 1
        for i in range(n):
            total_ways = total_ways * dp[i + 1] % MOD

        return total_ways