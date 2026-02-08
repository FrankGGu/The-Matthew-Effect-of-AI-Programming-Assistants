class Solution:
    def maxPalindromes(self, s: str, k: int) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        is_palindrome = [[False] * n for _ in range(n)]

        for i in range(n-1, -1, -1):
            for j in range(i, n):
                if s[i] == s[j] and (j - i <= 1 or is_palindrome[i+1][j-1]):
                    is_palindrome[i][j] = True

        for i in range(1, n + 1):
            dp[i] = dp[i-1]
            for j in range(i - k, -1, -1):
                if is_palindrome[j][i-1]:
                    dp[i] = max(dp[i], dp[j] + 1)
                    break

        return dp[n]