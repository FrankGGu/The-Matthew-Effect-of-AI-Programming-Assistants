class Solution:
    def shiftDistance(self, s: str, t: str) -> int:
        if len(s) != len(t):
            return -1

        n = len(s)
        if s == t:
            return 0

        for shift in range(1, n):
            if s[shift:] + s[:shift] == t:
                return shift

        return -1