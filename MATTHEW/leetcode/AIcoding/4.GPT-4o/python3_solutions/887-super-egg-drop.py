class Solution:
    def superEggDrop(self, K: int, N: int) -> int:
        dp = [[0] * (N + 1) for _ in range(K + 1)]

        for n in range(1, N + 1):
            dp[1][n] = n

        for k in range(2, K + 1):
            for n in range(1, N + 1):
                dp[k][n] = float('inf')
                for x in range(1, n + 1):
                    res = 1 + max(dp[k - 1][x - 1], dp[k][n - x])
                    dp[k][n] = min(dp[k][n], res)

        return dp[K][N]