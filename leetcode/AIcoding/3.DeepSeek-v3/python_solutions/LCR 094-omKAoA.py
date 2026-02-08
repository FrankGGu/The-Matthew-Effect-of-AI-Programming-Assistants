class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        is_palindrome = [[False] * n for _ in range(n)]
        for i in range(n):
            is_palindrome[i][i] = True
        for i in range(n - 1, -1, -1):
            for j in range(i + 1, n):
                if s[i] == s[j]:
                    if j - i == 1 or is_palindrome[i + 1][j - 1]:
                        is_palindrome[i][j] = True
        dp = [0] * n
        for i in range(1, n):
            if is_palindrome[0][i]:
                dp[i] = 0
                continue
            min_cuts = float('inf')
            for j in range(i):
                if is_palindrome[j + 1][i]:
                    min_cuts = min(min_cuts, dp[j] + 1)
            dp[i] = min_cuts
        return dp[-1]