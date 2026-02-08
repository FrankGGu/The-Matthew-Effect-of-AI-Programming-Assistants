class Solution:
    def maximizePalindromeLength(self, word1: str, word2: str) -> int:
        s = word1 + word2
        n1 = len(word1)
        n = len(s)

        # dp[i][j] stores the length of the longest palindromic subsequence of s[i...j]
        dp = [[0] * n for _ in range(n)]

        # Base case: single characters are palindromes of length 1
        for i in range(n):
            dp[i][i] = 1

        # Fill the DP table for lengths from 2 to n
        for length in range(2, n + 1):
            # Starting index i
            for i in range(n - length + 1):
                # Ending index j
                j = i + length - 1
                if s[i] == s[j]:
                    # If s[i] and s[j] match, they can extend a palindrome.
                    # The length is 2 (for s[i] and s[j]) plus the LPS of the inner substring s[i+1...j-1].
                    # dp[i+1][j-1] will be 0 if i+1 > j-1 (empty inner string), which is correct.
                    dp[i][j] = 2 + dp[i+1][j-1]
                else:
                    # If s[i] and s[j] don't match, take the maximum of excluding s[i] or s[j].
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])

        max_len = 0
        # Iterate through all possible pairs (i, j) such that s[i] is from word1
        # and s[j] is from word2, and s[i] == s[j].
        # This ensures the palindrome "crosses" the boundary and uses at least one character
        # from word1 and at least one character from word2, fulfilling the problem's condition
        # of concatenating two non-empty subsequences.
        for i in range(n1):  # i from 0 to len(word1)-1
            for j in range(n1, n):  # j from len(word1) to len(s)-1
                if s[i] == s[j]:
                    # If s[i] and s[j] match, they can form the outermost pair of a palindrome.
                    # The total length is 2 (for s[i] and s[j]) plus the LPS of the substring s[i+1...j-1].
                    max_len = max(max_len, 2 + dp[i+1][j-1])

        return max_len