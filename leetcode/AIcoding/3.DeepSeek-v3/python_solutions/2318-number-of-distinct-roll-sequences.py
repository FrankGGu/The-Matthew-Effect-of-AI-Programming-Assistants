class Solution:
    def distinctSequences(self, n: int) -> int:
        if n == 1:
            return 6

        MOD = 10**9 + 7
        from math import gcd

        dp = [[[0] * 7 for _ in range(7)] for __ in range(n + 1)]

        for i in range(1, 7):
            for j in range(1, 7):
                if i != j and gcd(i, j) == 1:
                    dp[2][i][j] = 1

        for k in range(3, n + 1):
            for i in range(1, 7):
                for j in range(1, 7):
                    if i != j and gcd(i, j) == 1:
                        for l in range(1, 7):
                            if l != j and (i == 0 or l != i):
                                dp[k][j][l] = (dp[k][j][l] + dp[k - 1][i][j]) % MOD

        total = 0
        for i in range(1, 7):
            for j in range(1, 7):
                total = (total + dp[n][i][j]) % MOD

        return total