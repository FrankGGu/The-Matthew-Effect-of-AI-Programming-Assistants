class Solution:
    def numDecodings(self, s: str) -> int:
        n = len(s)
        if n == 0:
            return 0

        dp = [0] * (n + 1)
        dp[0] = 1  # Base case: an empty string has one way to decode (do nothing)

        for i in range(1, n + 1):
            # Check for single digit decoding
            if s[i - 1] != '0':
                dp[i] += dp[i - 1]

            # Check for two digit decoding
            if i >= 2:
                two_digit_str = s[i - 2:i]
                two_digit_val = int(two_digit_str)

                # The first digit of a two-digit number cannot be '0'
                # And the value must be between 10 and 26 inclusive
                if s[i - 2] != '0' and 10 <= two_digit_val <= 26:
                    dp[i] += dp[i - 2]

        return dp[n]