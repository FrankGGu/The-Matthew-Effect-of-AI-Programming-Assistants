class Solution:
    def maxPalindromicPairs(self, s: str) -> int:
        n = len(s)
        dp = [0] * (n + 1)
        for i in range(n):
            for j in range(i, n):
                if s[i] == s[j]:
                    dp[j + 1] = max(dp[j + 1], dp[i] + 1)
        return dp[n]