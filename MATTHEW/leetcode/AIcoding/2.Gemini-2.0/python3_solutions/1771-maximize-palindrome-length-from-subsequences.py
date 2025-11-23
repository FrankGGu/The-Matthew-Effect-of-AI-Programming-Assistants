class Solution:
    def maxPalindrome(self, word1: str, word2: str) -> int:
        s = word1 + word2
        n1 = len(word1)
        n2 = len(word2)
        n = len(s)
        dp = [[0] * n for _ in range(n)]
        for i in range(n):
            dp[i][i] = 1
        for i in range(n - 1):
            if s[i] == s[i + 1]:
                dp[i][i + 1] = 2
            else:
                dp[i][i + 1] = 1
        for length in range(3, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if s[i] == s[j]:
                    dp[i][j] = dp[i + 1][j - 1] + 2
                else:
                    dp[i][j] = max(dp[i + 1][j], dp[i][j - 1])
        ans = 0
        for i in range(n1):
            for j in range(n1, n):
                if word1[i] == word2[j - n1]:
                    ans = max(ans, dp[i][j])
        return ans