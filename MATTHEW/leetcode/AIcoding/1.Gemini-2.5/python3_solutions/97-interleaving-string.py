class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        n1, n2, n3 = len(s1), len(s2), len(s3)

        if n1 + n2 != n3:
            return False

        dp = [[False] * (n2 + 1) for _ in range(n1 + 1)]

        dp[0][0] = True

        for i in range(1, n1 + 1):
            if dp[i-1][0] and s1[i-1] == s3[i-1]:
                dp[i][0] = True

        for j in range(1, n2 + 1):
            if dp[0][j-1] and s2[j-1] == s3[j-1]:
                dp[0][j] = True

        for i in range(1, n1 + 1):
            for j in range(1, n2 + 1):
                from_s1 = dp[i-1][j] and s1[i-1] == s3[i+j-1]
                from_s2 = dp[i][j-1] and s2[j-1] == s3[i+j-1]
                dp[i][j] = from_s1 or from_s2

        return dp[n1][n2]