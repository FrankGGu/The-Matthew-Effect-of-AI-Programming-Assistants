class Solution:
    def minimumPushes(self, word: str) -> int:
        freq = {}
        for c in word:
            freq[c] = freq.get(c, 0) + 1

        sorted_chars = sorted(freq.keys(), key=lambda x: -freq[x])

        total_pushes = 0
        for i, char in enumerate(sorted_chars):
            presses = (i // 8) + 1
            total_pushes += presses * freq[char]

        return total_pushes