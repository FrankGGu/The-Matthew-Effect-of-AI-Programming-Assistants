class Solution:
    def longestPalindromeSubseq(self, s: str) -> int:
        n = len(s)

        dp = [[0] * n for _ in range(n)]

        # Base case: A single character is a palindrome of length 1
        for i in range(n):
            dp[i][i] = 1

        # Fill the DP table
        # Iterate over substring length (gap between i and j)
        for length in range(2, n + 1):
            # Iterate over starting index i
            for i in range(n - length + 1):
                j = i + length - 1 # Calculate ending index j

                if s[i] == s[j]:
                    # If characters match, they can form part of the palindrome
                    # Add 2 to the LPS of the inner substring s[i+1...j-1]
                    # If length is 2 (e.g., "aa"), then i+1 > j-1, dp[i+1][j-1] is 0
                    dp[i][j] = 2 + dp[i+1][j-1]
                else:
                    # If characters don't match, we must exclude one of them
                    # Take the maximum of LPS of s[i+1...j] or s[i...j-1]
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])

        # The result for the entire string s is dp[0][n-1]
        return dp[0][n-1]