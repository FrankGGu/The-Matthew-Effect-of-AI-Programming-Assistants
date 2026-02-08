class Solution:
    def countSpecialSubsequences(self, s: str) -> int:
        MOD = 10**9 + 7

        # dp[0]: count of subsequences of '1'
        # dp[1]: count of subsequences of '1' followed by one or more '2's (e.g., '12', '122')
        # dp[2]: count of special subsequences (i.e., '1', followed by zero or more '2's, followed by '3')

        dp = [0, 0, 0]

        for char in s:
            if char == '1':
                # When a '1' is encountered:
                # It can start a new '1' subsequence.
                # It can also be appended to existing '1' subsequences.
                # So, dp[0] doubles (for keeping or extending) and adds 1 (for the '1' itself).
                dp[0] = (2 * dp[0] + 1) % MOD
            elif char == '2':
                # When a '2' is encountered:
                # It can be appended to existing '1' subsequences to form '12'. (dp[0] ways)
                # It can also be appended to existing '12...' subsequences to form '122...'. (dp[1] ways)
                # So, dp[1] doubles (for keeping or extending) and adds dp[0] (for extending '1's).
                dp[1] = (2 * dp[1] + dp[0]) % MOD
            elif char == '3':
                # When a '3' is encountered:
                # It can be appended to existing '12...' subsequences to form '12...3'. (dp[1] ways)
                # It can also be appended to existing '1' subsequences to form '13' (zero '2's). (dp[0] ways)
                # It can also be appended to existing '12...3' subsequences to form '12...33'. (dp[2] ways)
                # So, dp[2] doubles (for keeping or extending) and adds dp[1] (for extending '12...'s) and adds dp[0] (for extending '1's).
                dp[2] = (2 * dp[2] + dp[1] + dp[0]) % MOD

        return dp[2]