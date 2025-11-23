class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        if n <= 1:
            return 0

        dp = [0] * n
        for i in range(n):
            dp[i] = i

        is_palindrome = [[False] * n for _ in range(n)]

        for right in range(n):
            for left in range(right + 1):
                if s[left] == s[right] and (right - left < 2 or is_palindrome[left + 1][right - 1]):
                    is_palindrome[left][right] = True
                    if left == 0:
                        dp[right] = 0
                    else:
                        dp[right] = min(dp[right], dp[left - 1] + 1)

        return dp[n - 1]