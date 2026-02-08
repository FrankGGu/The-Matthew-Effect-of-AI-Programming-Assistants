import collections

class Solution:
    def smallestPalindromicRearrangement(self, s: str) -> str:
        counts = collections.Counter(s)

        first_half_chars = []
        middle_char = ""

        # Iterate through characters in alphabetical order
        # to build the lexicographically smallest first half
        for char_code in range(ord('a'), ord('z') + 1):
            char = chr(char_code)
            if char in counts:
                count = counts[char]

                # If a character has an odd count, it must be the middle character
                # There can be at most one such character in a palindrome
                if count % 2 == 1:
                    middle_char = char
                    # Add the even part of its count to the first half
                    first_half_chars.append(char * ((count - 1) // 2))
                else:
                    # Add half of the characters to the first half
                    first_half_chars.append(char * (count // 2))

        first_half_str = "".join(first_half_chars)

        # Construct the palindrome: first_half + middle_char + reversed(first_half)
        return first_half_str + middle_char + first_half_str[::-1]