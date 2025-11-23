class Solution:
    def numberOfSpecialChars(self, word: str) -> int:
        lower_chars = set()
        upper_chars = set()

        for char_code in word:
            if 'a' <= char_code <= 'z':
                lower_chars.add(char_code)
            elif 'A' <= char_code <= 'Z':
                upper_chars.add(char_code)

        count = 0
        for char_code in lower_chars:
            if char_code.upper() in upper_chars:
                count += 1

        return count