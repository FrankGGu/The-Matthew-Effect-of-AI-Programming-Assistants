from collections import Counter

class Solution:
    def minSetSize(self, arr: list[int]) -> int:
        counts = Counter(arr)
        freqs = sorted(counts.values(), reverse=True)
        n = len(arr)
        removed = 0
        count = 0
        for freq in freqs:
            removed += freq
            count += 1
            if removed >= n // 2:
                return count
        return count