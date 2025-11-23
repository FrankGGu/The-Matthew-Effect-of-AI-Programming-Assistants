import string

class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        unique_palindromes_count = 0

        for char_code in range(ord('a'), ord('z') + 1):
            outer_char = chr(char_code)

            first_idx = s.find(outer_char)

            if first_idx == -1:
                continue

            last_idx = s.rfind(outer_char)

            if first_idx < last_idx:
                middle_substring = s[first_idx + 1 : last_idx]

                unique_middle_chars = set(middle_substring)

                unique_palindromes_count += len(unique_middle_chars)

        return unique_palindromes_count