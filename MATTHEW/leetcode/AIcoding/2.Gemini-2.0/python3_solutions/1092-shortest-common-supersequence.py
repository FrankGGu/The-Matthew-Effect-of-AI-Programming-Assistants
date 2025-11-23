class Solution:
    def shortestCommonSupersequence(self, str1: str, str2: str) -> str:
        n = len(str1)
        m = len(str2)
        dp = [["" for _ in range(m + 1)] for _ in range(n + 1)]

        for i in range(n + 1):
            for j in range(m + 1):
                if i == 0:
                    dp[i][j] = str2[:j]
                elif j == 0:
                    dp[i][j] = str1[:i]
                elif str1[i - 1] == str2[j - 1]:
                    dp[i][j] = dp[i - 1][j - 1] + str1[i - 1]
                else:
                    dp[i][j] = min(dp[i - 1][j] + str1[i - 1], dp[i][j - 1] + str2[j - 1], key=len)

        return dp[n][m]