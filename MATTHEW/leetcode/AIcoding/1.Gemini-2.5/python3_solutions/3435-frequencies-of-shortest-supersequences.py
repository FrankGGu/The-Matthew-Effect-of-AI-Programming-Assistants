class Solution:
    def shortestCommonSupersequence(self, str1: str, str2: str) -> int:
        n = len(str1)
        m = len(str2)
        MOD = 10**9 + 7

        dp = [[0] * (m + 1) for _ in range(n + 1)]
        ways = [[0] * (m + 1) for _ in range(n + 1)]

        for i in range(n + 1):
            dp[i][0] = i
            ways[i][0] = 1

        for j in range(m + 1):
            dp[0][j] = j
            ways[0][j] = 1

        for i in range(1, n + 1):
            for j in range(1, m + 1):
                if str1[i-1] == str2[j-1]:
                    dp[i][j] = 1 + dp[i-1][j-1]
                    ways[i][j] = ways[i-1][j-1]
                else:
                    len1 = 1 + dp[i-1][j]
                    ways1 = ways[i-1][j]

                    len2 = 1 + dp[i][j-1]
                    ways2 = ways[i][j-1]

                    if len1 < len2:
                        dp[i][j] = len1
                        ways[i][j] = ways1
                    elif len2 < len1:
                        dp[i][j] = len2
                        ways[i][j] = ways2
                    else:
                        dp[i][j] = len1
                        ways[i][j] = (ways1 + ways2) % MOD

        return ways[n][m]