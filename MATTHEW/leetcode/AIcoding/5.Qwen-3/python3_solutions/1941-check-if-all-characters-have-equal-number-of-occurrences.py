class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        from collections import Counter
        counts = Counter(s)
        first = next(iter(counts.values()))
        for count in counts.values():
            if count != first:
                return False
        return True