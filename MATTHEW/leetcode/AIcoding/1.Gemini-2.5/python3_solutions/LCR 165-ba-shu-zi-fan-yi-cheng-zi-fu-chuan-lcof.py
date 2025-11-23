class Solution:
    def translateNum(self, num: int) -> int:
        s = str(num)
        n = len(s)

        # dp_prev2 represents dp[i-2] (number of ways to translate s[0...i-3])
        # dp_prev1 represents dp[i-1] (number of ways to translate s[0...i-2])
        # dp_curr represents dp[i] (number of ways to translate s[0...i-1])

        # Base case: For an empty string (length 0), there's 1 way (empty translation).
        # This corresponds to dp[0] in a 0-indexed string or dp[0] for length 0.
        dp_prev2 = 1 

        # Base case: For a string of length 1 (s[0]), there's 1 way.
        # (e.g., '0' -> 'a', '1' -> 'b', etc. All single digits 0-9 are valid.)
        # This corresponds to dp[1] for length 1.
        dp_prev1 = 1

        # Iterate from the second character (index 1) up to the last character (index n-1).
        # In this loop, `i` represents the current index of the character being considered as the *end* of a potential two-digit number.
        # We are calculating dp[i+1] based on dp[i] and dp[i-1].
        # The loop variable `i` here effectively corresponds to `k-1` if `k` is the length of the substring being considered.
        for i in range(1, n):
            # `dp_curr` will store the number of ways to translate the substring s[0...i].
            # It is initialized with the ways from translating s[0...i-1] by taking s[i] as a single digit.
            dp_curr = dp_prev1

            # Check if the last two digits s[i-1:i+1] form a valid two-digit translation (10-25).
            # s[i-1] is the previous character, s[i] is the current character.
            two_digits_num = int(s[i-1:i+1])

            if 10 <= two_digits_num <= 25:
                # If valid, add the number of ways to translate s[0...i-2] (dp_prev2)
                # because s[i-1:i+1] can be translated as a pair.
                dp_curr += dp_prev2

            # Update dp_prev2 and dp_prev1 for the next iteration.
            # dp_prev2 becomes the old dp_prev1.
            # dp_prev1 becomes the newly calculated dp_curr.
            dp_prev2 = dp_prev1
            dp_prev1 = dp_curr

        # After the loop, dp_prev1 holds the total number of ways to translate the entire string s (length n).
        return dp_prev1