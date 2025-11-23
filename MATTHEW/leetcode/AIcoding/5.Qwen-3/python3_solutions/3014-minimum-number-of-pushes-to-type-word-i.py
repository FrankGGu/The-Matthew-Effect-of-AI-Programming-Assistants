class Solution:
    def minimumPushes(self, word: str) -> int:
        from collections import Counter

        counts = Counter(word)
        sorted_counts = sorted(counts.values(), reverse=True)
        pushes = 0
        for i, count in enumerate(sorted_counts):
            pushes += (i // 8 + 1) * count
        return pushes