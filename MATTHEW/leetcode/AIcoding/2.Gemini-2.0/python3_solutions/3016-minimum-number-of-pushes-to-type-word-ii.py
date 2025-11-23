from collections import defaultdict

class Solution:
    def minimumPushes(self, word: str) -> int:
        freq = defaultdict(int)
        for char in word:
            freq[char] += 1

        sorted_freq = sorted(freq.values(), reverse=True)

        total_pushes = 0

        for i in range(len(sorted_freq)):
            if i < 8:
                total_pushes += sorted_freq[i]
            elif i < 16:
                total_pushes += 2 * sorted_freq[i]
            elif i < 24:
                total_pushes += 3 * sorted_freq[i]
            else:
                total_pushes += 4 * sorted_freq[i]

        return total_pushes