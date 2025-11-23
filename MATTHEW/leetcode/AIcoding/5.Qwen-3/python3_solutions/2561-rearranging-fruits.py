class Solution:
    def rearrangeFruits(self, fruits: str) -> int:
        from collections import Counter

        count = Counter(fruits)
        res = 0
        for c in count:
            if count[c] % 2 == 1:
                res += 1
        return res