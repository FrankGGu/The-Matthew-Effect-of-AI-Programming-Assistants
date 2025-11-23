class Solution:
    def minDeletions(self, s: str) -> int:
        from collections import Counter

        freq = Counter(s)
        counts = sorted(freq.values(), reverse=True)
        deletions = 0
        seen = set()

        for count in counts:
            while count > 0 and count in seen:
                count -= 1
                deletions += 1
            seen.add(count)

        return deletions