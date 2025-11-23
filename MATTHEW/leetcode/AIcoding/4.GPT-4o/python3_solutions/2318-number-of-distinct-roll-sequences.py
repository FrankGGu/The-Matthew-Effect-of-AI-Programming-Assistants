class Solution:
    def distinctSequences(self, n: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * 7 for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(1, n + 1):
            for j in range(1, 7):
                for k in range(1, 7):
                    if j != k and (j + k) % 7 != 0:
                        for p in range(1, 7):
                            if p != j and p != k:
                                dp[i][j] = (dp[i][j] + dp[i - 1][p]) % MOD

        return sum(dp[n]) % MOD