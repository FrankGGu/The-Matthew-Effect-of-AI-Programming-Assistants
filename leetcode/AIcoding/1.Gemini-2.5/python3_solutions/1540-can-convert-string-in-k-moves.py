class Solution:
    def canConvertString(self, s: str, t: str, k: int) -> bool:
        if len(s) != len(t):
            return False

        # counts[d] stores how many times we've needed a base shift of 'd'.
        # The actual shift value for the m-th occurrence of 'd' will be d + (m-1)*26.
        # This value must be less than or equal to k.
        counts = [0] * 26 

        for i in range(len(s)):
            if s[i] == t[i]:
                continue

            # Calculate the minimum positive shift needed to change s[i] to t[i].
            # This value 'diff' will be between 1 and 25.
            diff = (ord(t[i]) - ord(s[i]) + 26) % 26

            # This is the (counts[diff] + 1)-th time we need a base shift of 'diff'.
            # To avoid using the same shift count (e.g., both 1 and 1 for two different characters),
            # we must add multiples of 26.
            # For the 1st time needing 'diff', counts[diff] is 0, actual_shift = diff + 0*26 = diff.
            # For the 2nd time needing 'diff', counts[diff] is 1, actual_shift = diff + 1*26.
            # For the m-th time needing 'diff', counts[diff] is m-1, actual_shift = diff + (m-1)*26.
            actual_shift_value = diff + counts[diff] * 26

            # If the actual shift value required for this character exceeds k,
            # then it's impossible to convert the string.
            if actual_shift_value > k:
                return False

            # Increment the count for this base shift 'diff' as it has been used once more.
            counts[diff] += 1

        # If we successfully processed all characters without exceeding k, then it's possible.
        return True