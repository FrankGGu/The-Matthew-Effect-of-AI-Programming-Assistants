class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)
        ones = 0
        flips = 0
        for i in range(n):
            if s[i] == '1':
                ones += 1
            else:
                flips = min(ones, flips + 1)
        return flips