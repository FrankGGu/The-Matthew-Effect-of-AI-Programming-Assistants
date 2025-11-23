class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        ones = 0
        flips = 0
        for c in s:
            if c == '1':
                ones += 1
            else:
                flips = min(ones, flips + 1)
        return flips