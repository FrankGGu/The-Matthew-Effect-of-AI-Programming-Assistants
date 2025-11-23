class Solution:
    def memLeakRate(self, m: int) -> int:
        i = 1
        while m >= i:
            m -= i
            i += 1
        return i