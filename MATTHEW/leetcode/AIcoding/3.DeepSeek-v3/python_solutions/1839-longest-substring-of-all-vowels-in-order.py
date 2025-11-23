class Solution:
    def longestBeautifulSubstring(self, word: str) -> int:
        max_len = 0
        current_len = 1
        unique_count = 1

        for i in range(1, len(word)):
            if word[i] > word[i-1]:
                current_len += 1
                unique_count += 1
            elif word[i] == word[i-1]:
                current_len += 1
            else:
                current_len = 1
                unique_count = 1

            if unique_count == 5:
                max_len = max(max_len, current_len)

        return max_len