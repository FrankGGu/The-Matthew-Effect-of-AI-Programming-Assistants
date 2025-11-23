from typing import List

class Solution:
    def minBooths(self, words: List[str]) -> int:
        max_freq = [0] * 26

        for word in words:
            current_freq = [0] * 26
            for char in word:
                current_freq[ord(char) - ord('a')] += 1

            for i in range(26):
                max_freq[i] = max(max_freq[i], current_freq[i])

        total_booths = sum(max_freq)
        return total_booths