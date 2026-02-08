class Solution:
    def minOperations(self, s: str) -> int:
        from collections import Counter
        freq = Counter(s)
        counts = list(freq.values())
        max_count = max(counts)
        return sum(max_count - count for count in counts)