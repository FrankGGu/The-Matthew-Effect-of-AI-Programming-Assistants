class Solution:
    def longestSubstring(self, word: str) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        max_len = 0
        current_len = 0
        prev_char = ''

        for char in word:
            if char in vowels and (prev_char == '' or vowels.index(char) >= vowels.index(prev_char)):
                current_len += 1
            else:
                current_len = 1 if char in vowels else 0
            max_len = max(max_len, current_len)
            prev_char = char

        return max_len