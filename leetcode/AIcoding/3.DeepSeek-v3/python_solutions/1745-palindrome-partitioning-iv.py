class Solution:
    def checkPartitioning(self, s: str) -> bool:
        n = len(s)
        dp = [[False] * n for _ in range(n)]

        for i in range(n-1, -1, -1):
            for j in range(i, n):
                if s[i] == s[j]:
                    if j - i <= 2 or dp[i+1][j-1]:
                        dp[i][j] = True

        for i in range(1, n-1):
            for j in range(i, n-1):
                if dp[0][i-1] and dp[i][j] and dp[j+1][n-1]:
                    return True
        return False