class Solution:
    def greatestLetter(self, s: str) -> str:

        seen_chars = set(s)

        for i in range(25, -1, -1):
            upper_char = chr(ord('A') + i)
            lower_char = chr(ord('a') + i)

            if upper_char in seen_chars and lower_char in seen_chars:
                return upper_char

        return ""