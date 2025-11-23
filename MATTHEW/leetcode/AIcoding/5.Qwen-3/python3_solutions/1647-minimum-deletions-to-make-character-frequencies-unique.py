class Solution:
    def minDeletions(self, s: str) -> int:
        from collections import Counter

        freq = Counter(s)
        used_frequencies = set()
        deletions = 0

        for char, count in freq.items():
            while count > 0 and count in used_frequencies:
                count -= 1
                deletions += 1
            if count > 0:
                used_frequencies.add(count)

        return deletions