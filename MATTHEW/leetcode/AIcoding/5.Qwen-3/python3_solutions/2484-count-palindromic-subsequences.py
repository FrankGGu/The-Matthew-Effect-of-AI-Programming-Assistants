class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        n = len(s)
        dp = [[0] * n for _ in range(n)]

        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if s[i] == s[j]:
                    if length == 2:
                        dp[i][j] = 2
                    else:
                        dp[i][j] = dp[i + 1][j - 1] * 2
                        if s[i + 1] == s[j - 1]:
                            dp[i][j] += 2
                        elif s[i + 1] == s[j]:
                            dp[i][j] += 1
                        elif s[i] == s[j - 1]:
                            dp[i][j] += 1
                else:
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1]

        return dp[0][n - 1]