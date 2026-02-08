class Solution:
    def keyboard(self, k: int, n: int) -> int:
        MOD = 10**9 + 7

        dp = [[0] * (n + 1) for _ in range(27)]
        dp[0][0] = 1

        for i in range(1, 27):
            for j in range(n + 1):
                for t in range(min(j, k) + 1):
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - t] * self.comb(j, t)) % MOD

        return dp[26][n]

    def comb(self, n, k):
        res = 1
        for i in range(k):
            res = res * (n - i) // (i + 1)
        return res