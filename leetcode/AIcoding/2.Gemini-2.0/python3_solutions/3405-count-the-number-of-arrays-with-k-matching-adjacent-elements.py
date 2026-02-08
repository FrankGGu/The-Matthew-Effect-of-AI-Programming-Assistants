class Solution:
    def numberOfArrays(self, n: int, k: int, x: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * 2 for _ in range(n)]
        dp[0][1] = 1
        for i in range(1, n):
            dp[i][0] = dp[i - 1][1]
            dp[i][1] = (dp[i - 1][0] * (x - 1) + dp[i - 1][1] * (x - 2)) % MOD if x > 1 else 0
        return dp[n - 1][1]