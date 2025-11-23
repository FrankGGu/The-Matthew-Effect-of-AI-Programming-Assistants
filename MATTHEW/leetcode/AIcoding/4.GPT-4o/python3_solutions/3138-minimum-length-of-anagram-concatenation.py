class Solution:
    def minLength(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        odd_count = sum(1 for v in count.values() if v % 2 == 1)

        if odd_count == 0:
            return 0
        return odd_count