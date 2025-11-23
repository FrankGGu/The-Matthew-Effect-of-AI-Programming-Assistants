class Solution:
    def maxPalindromes(self, s: str, k: int) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        is_palindrome = [[False] * n for _ in range(n)]

        for length in range(1, n + 1):
            for start in range(n - length + 1):
                end = start + length - 1
                if s[start] == s[end]:
                    if length <= 2 or is_palindrome[start + 1][end - 1]:
                        is_palindrome[start][end] = True

        for i in range(n):
            dp[i + 1] = dp[i]
            for j in range(i + 1):
                if is_palindrome[j][i] and (i - j + 1) >= k:
                    dp[i + 1] = max(dp[i + 1], dp[j] + 1)

        return dp[n]