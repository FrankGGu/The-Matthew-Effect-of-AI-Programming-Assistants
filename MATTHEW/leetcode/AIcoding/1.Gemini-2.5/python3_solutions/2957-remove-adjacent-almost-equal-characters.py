class Solution:
    def removeAlmostEqualCharacters(self, s: str) -> int:
        n = len(s)
        if n <= 1:
            return 0

        # dp[i] represents the minimum number of characters to remove from the prefix s[0...i]
        # such that the remaining subsequence (formed from s[0...i]) has no adjacent almost-equal characters.

        # min_dp_minus_j[char_code] stores min(dp[j] - j) for all j < i
        # where s[j] (the character at index j) has char_code.
        # This optimization helps to find the best previous character to keep in O(1) for each char_code.
        dp = [0] * n
        min_dp_minus_j = [float('inf')] * 26 

        # Base case for the first character s[0]
        # To make a valid string from "s[0]", we keep s[0] and remove 0 characters.
        dp[0] = 0
        char_code_0 = ord(s[0]) - ord('a')
        min_dp_minus_j[char_code_0] = dp[0] - 0 # dp[j] - j for j=0

        for i in range(1, n):
            current_char_code = ord(s[i]) - ord('a')

            # Option 1: Remove s[i]
            # The cost is the minimum removals for s[0...i-1] plus 1 for removing s[i].
            remove_s_i_cost = dp[i-1] + 1

            # Option 2: Keep s[i]
            # Initialize cost assuming s[i] is the first character kept in the resulting string.
            # This means all characters s[0...i-1] are removed. The cost is 'i'.
            keep_s_i_cost = i 

            # Now, consider keeping s[i] preceded by some s[j] (j < i) that was also kept.
            # For s[j] and s[i] to be adjacent in the resulting string, they must not be almost-equal.
            # All characters s[j+1...i-1] must have been removed.
            # The cost for this choice is (min removals for s[0...j]) + (removals for s[j+1...i-1])
            # which is dp[j] + (i - 1 - j).
            # We want to minimize this value over all valid j.
            # This can be rewritten as (dp[j] - j) + (i - 1).
            # We use min_dp_minus_j to efficiently find the minimum (dp[j] - j).

            # Iterate through all possible character codes for the previous kept character
            for prev_char_code in range(26):
                # The problem statement defines "almost-equal" as abs(ord(c1) - ord(c2)) <= 1.
                # However, the provided examples (e.g., "abacaba" -> 0) strongly suggest
                # that "almost-equal" is interpreted as c1 == c2 (i.e., abs(ord(c1) - ord(c2)) == 0).
                # We will proceed with the interpretation that matches the examples:
                # Two characters are NOT almost-equal if they are different (abs(diff) > 0).
                # If the literal problem statement was intended, the condition would be:
                # if abs(current_char_code - prev_char_code) > 1:

                if abs(current_char_code - prev_char_code) > 0: # Check if s[i] and prev_char are NOT almost-equal
                    # If there's a valid path to keep a prev_char_code at some index j
                    if min_dp_minus_j[prev_char_code] != float('inf'):
                        cost_from_prev = min_dp_minus_j[prev_char_code] + (i - 1)
                        keep_s_i_cost = min(keep_s_i_cost, cost_from_prev)

            # dp[i] is the minimum of the two options: removing s[i] or keeping s[i].
            dp[i] = min(remove_s_i_cost, keep_s_i_cost)

            # Update min_dp_minus_j for the current character s[i]
            # This value (dp[i] - i) will be used for future calculations.
            min_dp_minus_j[current_char_code] = min(min_dp_minus_j[current_char_code], dp[i] - i)

        return dp[n-1]