import collections

class Solution:
    def smallestPalindromicRearrangement(self, s: str) -> str:
        counts = collections.Counter(s)

        first_half_chars = []
        middle_char = ''

        for char_code in range(ord('a'), ord('z') + 1):
            char = chr(char_code)
            if char in counts:
                first_half_chars.extend([char] * (counts[char] // 2))

                if counts[char] % 2 == 1:
                    middle_char = char

        first_half_str = "".join(first_half_chars)
        second_half_str = first_half_str[::-1]

        return first_half_str + middle_char + second_half_str