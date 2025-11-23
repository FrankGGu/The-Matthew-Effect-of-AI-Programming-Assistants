class Solution:
    def checkRecord(self, n: int) -> int:
        MOD = 10**9 + 7
        if n == 0:
            return 0
        dp = [[[0] * 3 for _ in range(2)] for __ in range(n + 1)]
        dp[0][0][0] = 1

        for i in range(1, n + 1):
            for a in range(2):
                for l in range(3):
                    # Add P
                    dp[i][a][0] = (dp[i][a][0] + dp[i-1][a][l]) % MOD
                    # Add A
                    if a < 1:
                        dp[i][a+1][0] = (dp[i][a+1][0] + dp[i-1][a][l]) % MOD
                    # Add L
                    if l < 2:
                        dp[i][a][l+1] = (dp[i][a][l+1] + dp[i-1][a][l]) % MOD

        res = 0
        for a in range(2):
            for l in range(3):
                res = (res + dp[n][a][l]) % MOD
        return res