class Solution:
    def minInsertions(self, s: str) -> int:
        n = len(s)
        s_reversed = s[::-1]

        # dp[i][j] will store the length of the Longest Common Subsequence (LCS)
        # of s[:i] and s_reversed[:j].
        # This LCS is equivalent to the Longest Palindromic Subsequence (LPS) of s.
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for j in range(1, n + 1):
                if s[i - 1] == s_reversed[j - 1]:
                    dp[i][j] = 1 + dp[i - 1][j - 1]
                else:
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])

        lps_length = dp[n][n]

        # The minimum number of insertions needed to make a string a palindrome
        # is equal to the string's length minus the length of its LPS.
        return n - lps_length