class Solution:
    def countWinningSequences(self, n: int, k: int, m: int) -> int:
        MOD = 10**9 + 7

        if m == 1:
            return 0

        dp = [[0] * (k + 2) for _ in range(n + 1)]

        for j in range(1, k + 1):
            dp[1][j] = 1

        for i in range(2, n + 1):
            for j in range(1, k + 1):
                if j > 1:
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD
                if j < k:
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD

        total = 0
        for i in range(1, n + 1):
            for j in range(1, k + 1):
                if j == m:
                    continue
                ways = dp[i][j]
                remaining = n - i
                if remaining == 0:
                    total = (total + ways) % MOD
                else:
                    if j > 1:
                        total = (total + ways) % MOD
                    if j < k:
                        total = (total + ways) % MOD

        return total