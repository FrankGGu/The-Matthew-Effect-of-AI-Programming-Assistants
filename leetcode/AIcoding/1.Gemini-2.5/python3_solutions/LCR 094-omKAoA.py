class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)

        is_palindrome = [[False] * n for _ in range(n)]

        for i in range(n):
            is_palindrome[i][i] = True

        for i in range(n - 1):
            if s[i] == s[i+1]:
                is_palindrome[i][i+1] = True

        for length in range(3, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if s[i] == s[j] and is_palindrome[i+1][j-1]:
                    is_palindrome[i][j] = True

        dp = [0] * (n + 1)

        for i in range(n + 1):
            dp[i] = i - 1

        for i in range(1, n + 1):
            for j in range(i):
                if is_palindrome[j][i-1]:
                    dp[i] = min(dp[i], dp[j] + 1)

        return dp[n]