class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        is_pal = [[False] * n for _ in range(n)]
        for i in range(n):
            for j in range(i, n):
                if s[i] == s[j] and (j - i <= 2 or is_pal[i + 1][j - 1]):
                    is_pal[i][j] = True
        dp = [0] * n
        for j in range(n):
            min_val = float('inf')
            for i in range(j + 1):
                if is_pal[i][j]:
                    if i == 0:
                        min_val = 0
                    else:
                        min_val = min(min_val, dp[i - 1] + 1)
            dp[j] = min_val
        return dp[-1]