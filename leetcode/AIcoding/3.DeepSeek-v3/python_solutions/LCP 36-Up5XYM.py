class Solution:
    def maxGroups(self, deck: List[int]) -> int:
        from collections import Counter
        count = Counter(deck)
        freq = sorted(count.values())
        res = 0
        prev = 0
        for f in freq:
            res += 1
            prev = f - 1
            if prev == 0:
                prev = 0
        return res