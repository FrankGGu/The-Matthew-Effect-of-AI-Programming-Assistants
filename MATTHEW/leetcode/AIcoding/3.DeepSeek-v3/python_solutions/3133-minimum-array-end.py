class Solution:
    def minEnd(self, n: int, x: int) -> int:
        res = x
        n -= 1
        i = 0
        while n > 0:
            if (res >> i) & 1 == 0:
                res |= (n & 1) << i
                n >>= 1
            i += 1
        return res