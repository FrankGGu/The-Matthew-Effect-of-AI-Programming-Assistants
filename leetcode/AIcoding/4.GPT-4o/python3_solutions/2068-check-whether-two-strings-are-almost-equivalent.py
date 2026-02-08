class Solution:
    def checkAlmostEquivalent(self, s: str, t: str) -> bool:
        from collections import Counter

        count_s = Counter(s)
        count_t = Counter(t)

        for char in set(count_s.keys()).union(count_t.keys()):
            if abs(count_s[char] - count_t[char]) > 1:
                return False
        return True