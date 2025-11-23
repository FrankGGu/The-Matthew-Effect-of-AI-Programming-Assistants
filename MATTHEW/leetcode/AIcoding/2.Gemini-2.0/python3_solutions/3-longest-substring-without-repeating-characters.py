class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        start = 0
        end = 0
        max_len = 0
        char_index = {}

        while end < len(s):
            if s[end] in char_index and char_index[s[end]] >= start:
                start = char_index[s[end]] + 1

            char_index[s[end]] = end
            max_len = max(max_len, end - start + 1)
            end += 1

        return max_len