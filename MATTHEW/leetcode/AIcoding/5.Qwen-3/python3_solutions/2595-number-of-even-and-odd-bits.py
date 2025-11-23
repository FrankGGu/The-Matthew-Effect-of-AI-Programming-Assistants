class Solution:
    def evenOddBit(self, n: int) -> int:
        even = 0
        odd = 0
        i = 0
        while n:
            if n & 1:
                if i % 2 == 0:
                    even += 1
                else:
                    odd += 1
            n >>= 1
            i += 1
        return even