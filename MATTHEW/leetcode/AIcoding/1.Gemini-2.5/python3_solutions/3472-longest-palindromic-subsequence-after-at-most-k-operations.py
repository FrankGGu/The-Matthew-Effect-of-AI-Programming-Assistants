class Solution:
    def longestPalindromicSubsequenceAfterKOperations(self, s: str, k: int) -> int:
        n = len(s)

        # dp[i][j][cost] stores the maximum length of a palindromic subsequence
        # for substring s[i...j] using 'cost' operations.
        # Initialize with 0s.
        # Dimensions: n x n x (k + 1)
        dp = [[[0] * (k + 1) for _ in range(n)] for _ in range(n)]

        # Base case: A single character is a palindrome of length 1, with 0 cost.
        # And if we have more operations, it's still length 1.
        for i in range(n):
            for cost in range(k + 1):
                dp[i][i][cost] = 1

        # Iterate over length of substring (L) from 2 to n
        for length in range(2, n + 1):
            # Iterate over starting index (i)
            for i in range(n - length + 1):
                j = i + length - 1 # Ending index (j)

                # Iterate over allowed operations (cost)
                for cost in range(k + 1):
                    # Case 1: Don't include s[i] or s[j] in the subsequence.
                    # This means taking the max from the subproblems s[i+1...j] or s[i...j-1].
                    # These indices are always valid since length >= 2.
                    dp[i][j][cost] = max(dp[i+1][j][cost], dp[i][j-1][cost])

                    # Case 2: Include s[i] and s[j] in the subsequence.
                    if s[i] == s[j]:
                        # If s[i] and s[j] are the same, no operation is needed for this pair.
                        # Add 2 to the length of the palindromic subsequence of s[i+1...j-1].
                        # dp[i+1][j-1][cost] will be 0 if i+1 > j-1 (empty substring), which correctly gives 0+2=2 for length 2.
                        dp[i][j][cost] = max(dp[i][j][cost], dp[i+1][j-1][cost] + 2)
                    else: # s[i] != s[j]
                        # If s[i] and s[j] are different, one operation is needed to make them match.
                        # This is only possible if we have at least 1 operation left.
                        if cost >= 1:
                            # Add 2 to the length of the palindromic subsequence of s[i+1...j-1]
                            # using one less operation (cost-1).
                            dp[i][j][cost] = max(dp[i][j][cost], dp[i+1][j-1][cost-1] + 2)

                    # Property of "at most k operations":
                    # If we can achieve a certain length with 'cost-1' operations,
                    # we can also achieve at least that length with 'cost' operations.
                    # This ensures that dp[i][j][cost] is non-decreasing with 'cost'.
                    if cost > 0:
                        dp[i][j][cost] = max(dp[i][j][cost], dp[i][j][cost-1])

        # The final answer is the maximum length for the entire string s[0...n-1]
        # using at most k operations.
        return dp[0][n-1][k]