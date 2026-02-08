class Solution:
    def maxPalindromes(self, s: str, k: int) -> int:
        n = len(s)

        # is_palindrome[i][j] will be True if s[i...j] is a palindrome
        is_palindrome = [[False] * n for _ in range(n)]

        # Base cases for palindrome table
        # All substrings of length 1 are palindromes
        for i in range(n):
            is_palindrome[i][i] = True

        # Substrings of length 2
        for i in range(n - 1):
            if s[i] == s[i+1]:
                is_palindrome[i][i+1] = True

        # Fill palindrome table for length >= 3
        for length in range(3, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1 # j is the end index of the current substring s[i...j]
                if s[i] == s[j] and is_palindrome[i+1][j-1]:
                    is_palindrome[i][j] = True

        # dp[i] will store the maximum number of non-overlapping palindrome substrings
        # in s[0...i-1]
        dp = [0] * (n + 1)

        for i in range(1, n + 1):
            # Option 1: Don't form a new palindrome ending at s[i-1].
            # In this case, the maximum count is the same as for s[0...i-2].
            dp[i] = dp[i-1]

            # Option 2: Try to form a new palindrome s[j...i-1]
            # Iterate through all possible starting positions 'j' for a palindrome ending at 'i-1'.
            # 'j' goes from 'i-1' down to 0.
            for j in range(i - 1, -1, -1):
                current_len = (i - 1) - j + 1

                # If the current palindrome candidate is too short, skip it.
                # Since 'j' is decreasing, 'current_len' is increasing.
                # We need to continue to smaller 'j' to find longer palindromes.
                if current_len < k:
                    continue

                # If s[j...i-1] is a palindrome and its length is at least k
                if is_palindrome[j][i-1]:
                    # If we choose s[j...i-1] as a palindrome, it must not overlap
                    # with previous palindromes. The previous palindromes must end
                    # before index 'j'. So, we look up dp[j].
                    prev_dp_val = dp[j]
                    dp[i] = max(dp[i], prev_dp_val + 1)

        return dp[n]