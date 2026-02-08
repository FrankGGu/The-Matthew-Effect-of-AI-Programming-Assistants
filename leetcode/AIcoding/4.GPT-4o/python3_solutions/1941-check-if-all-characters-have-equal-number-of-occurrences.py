class Solution:
    def areOccurrencesEqual(self, s: str) -> bool:
        from collections import Counter
        count = Counter(s)
        return len(set(count.values())) == 1