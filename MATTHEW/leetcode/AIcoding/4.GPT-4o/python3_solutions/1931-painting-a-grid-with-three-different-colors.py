class Solution:
    def countWays(self, h: int, w: int) -> int:
        MOD = 10**9 + 7
        if h > w:
            h, w = w, h

        dp = [[0] * (w + 1) for _ in range(h + 1)]
        dp[0][0] = 1

        for i in range(1, h + 1):
            for j in range(1, w + 1):
                dp[i][j] = (dp[i - 1][j] * 2 + dp[i][j - 1] * 2 - dp[i - 1][j - 1]) % MOD

        return (dp[h][w] * 3) % MOD