class Solution:
    def findTheOccurrence(self, s: str, t: str) -> int:
        def is_almost_equal(sub1, sub2):
            return sorted(sub1) == sorted(sub2)

        for i in range(len(s) - len(t) + 1):
            if is_almost_equal(s[i:i + len(t)], t):
                return i
        return -1