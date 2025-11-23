class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)

        is_palindrome = [[False] * n for _ in range(n)]

        for gap in range(n):
            for i in range(n - gap):
                j = i + gap
                if gap == 0:
                    is_palindrome[i][j] = True
                elif gap == 1:
                    is_palindrome[i][j] = (s[i] == s[j])
                else:
                    is_palindrome[i][j] = (s[i] == s[j] and is_palindrome[i + 1][j - 1])

        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            dp[i] = n - 1 - i 

            for j in range(i, n):
                if is_palindrome[i][j]:
                    if j == n - 1:
                        dp[i] = 0
                    else:
                        dp[i] = min(dp[i], 1 + dp[j + 1])

        return dp[0]