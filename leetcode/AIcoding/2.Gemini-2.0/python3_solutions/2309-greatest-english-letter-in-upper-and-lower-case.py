class Solution:
    def greatestLetter(self, s: str) -> str:
        letters = set(s)
        for char_code in range(ord('Z'), ord('A') - 1, -1):
            upper_char = chr(char_code)
            lower_char = chr(char_code + 32)
            if upper_char in letters and lower_char in letters:
                return upper_char
        return ""