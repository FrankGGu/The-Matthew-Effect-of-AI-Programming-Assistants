from collections import Counter

class Solution:
    def equalFrequency(self, word: str) -> bool:
        counts = Counter(word)
        for char in counts:
            temp_counts = counts.copy()
            temp_counts[char] -= 1
            if temp_counts[char] == 0:
                del temp_counts[char]

            if not temp_counts:
                return True

            freqs = set(temp_counts.values())
            if len(freqs) == 1:
                return True

        return False