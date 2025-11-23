import collections

class Solution:
    def largestPalindromic(self, num: str) -> str:
        freq = collections.Counter(num)

        left_half_chars = []

        # Build the left half of the palindrome by iterating digits from '9' down to '0'.
        # We prioritize larger digits for the outer parts of the palindrome.
        for d_char in "9876543210":
            d_int = int(d_char)
            count = freq[d_char]

            # Special handling for '0': '0' cannot be a leading digit if the left_half_chars
            # is currently empty (meaning no non-zero digits have been added yet).
            # This prevents palindromes like "010" from being formed if "1" is not available,
            # or "00" if the answer should be "0".
            if d_int == 0 and not left_half_chars:
                continue

            # Use pairs of digits for the left half
            pairs = count // 2
            left_half_chars.extend([d_char] * pairs)
            freq[d_char] -= pairs * 2

        middle_digit = ""
        # Find the largest single digit remaining (with an odd count) to be the middle digit.
        # Iterate from '9' down to '0' to ensure the largest possible middle digit.
        for d_char in "9876543210":
            if freq[d_char] % 2 == 1:
                middle_digit = d_char
                break

        # Construct the palindrome
        s_left = "".join(left_half_chars)
        s_right = s_left[::-1]

        ans = s_left + middle_digit + s_right

        # Handle edge cases where the result might be empty.
        # If 'ans' is empty, it means no pairs could be formed and no middle digit was found.
        # This typically happens if the input 'num' consisted only of '0's (e.g., "0", "00", "0000").
        # In such cases, if '0' was present in the original num, the answer is "0".
        # The problem constraints guarantee num is not empty and contains digits.
        if not ans: # This condition will only be true if num was composed entirely of '0's that formed pairs, or a single '0'.
            return "0"

        return ans