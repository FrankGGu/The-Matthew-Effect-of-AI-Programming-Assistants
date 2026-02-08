class Solution:
    def shiftDistance(self, s: str, t: str) -> int:
        n = len(s)
        m = len(t)
        if n != m:
            return -1

        if s == t:
            return 0

        for shift in range(1, n + 1):
            shifted_s = s[shift:] + s[:shift]
            if shifted_s == t:
                return shift

        return -1