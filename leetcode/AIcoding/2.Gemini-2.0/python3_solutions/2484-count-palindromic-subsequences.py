class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        n = len(s)
        dp = [[[0] * 4 for _ in range(n)] for _ in range(n)]
        MOD = 10**9 + 7

        for i in range(n):
            for j in range(4):
                if s[i] == 'a' and j == 0:
                    dp[i][i][j] = 1
                elif s[i] == 'b' and j == 1:
                    dp[i][i][j] = 1
                elif s[i] == 'c' and j == 2:
                    dp[i][i][j] = 1
                elif s[i] == 'd' and j == 3:
                    dp[i][i][j] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                for k in range(4):
                    if s[i] == chr(ord('a') + k) and s[j] == chr(ord('a') + k):
                        dp[i][j][k] = 2
                        for l in range(4):
                            dp[i][j][k] = (dp[i][j][k] + dp[i+1][j-1][l]) % MOD
                    else:
                        dp[i][j][k] = (dp[i][j][k] + dp[i][j-1][k]) % MOD
                        dp[i][j][k] = (dp[i][j][k] + dp[i+1][j][k]) % MOD
                        dp[i][j][k] = (dp[i][j][k] - dp[i+1][j-1][k] + MOD) % MOD

        ans = 0
        for i in range(4):
            ans = (ans + dp[0][n-1][i]) % MOD
        return ans