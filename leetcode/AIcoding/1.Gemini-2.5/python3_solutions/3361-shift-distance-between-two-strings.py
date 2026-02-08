class Solution:
    def shiftDistance(self, s: str, t: str) -> int:
        n = len(s)
        m = len(t)

        if n != m:
            return -1

        if s == t:
            return 0

        for i in range(1, n):
            shifted_s = s[i:] + s[:i]
            if shifted_s == t:
                return i

        return -1