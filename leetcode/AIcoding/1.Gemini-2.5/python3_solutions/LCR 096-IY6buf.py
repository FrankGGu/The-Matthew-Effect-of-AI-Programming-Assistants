class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        n1, n2, n3 = len(s1), len(s2), len(s3)

        if n1 + n2 != n3:
            return False

        dp = [[False] * (n2 + 1) for _ in range(n1 + 1)]

        dp[0][0] = True

        for i in range(n1 + 1):
            for j in range(n2 + 1):
                if i == 0 and j == 0:
                    continue

                s3_char_idx = i + j - 1

                if i > 0 and s1[i - 1] == s3[s3_char_idx] and dp[i - 1][j]:
                    dp[i][j] = True

                if j > 0 and s2[j - 1] == s3[s3_char_idx] and dp[i][j - 1]:
                    dp[i][j] = dp[i][j] or True

        return dp[n1][n2]