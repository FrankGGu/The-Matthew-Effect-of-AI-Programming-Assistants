class Solution:
    def minimumPushes(self, word: str) -> int:
        from collections import Counter

        freq = Counter(word)
        sorted_freq = sorted(freq.values(), reverse=True)
        pushes = 0
        for i, count in enumerate(sorted_freq):
            pushes += (i // 8 + 1) * count
        return pushes