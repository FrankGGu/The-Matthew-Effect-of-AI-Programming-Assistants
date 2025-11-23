class Solution:
    def minimizeXor(self, num1: int, num2: int) -> int:
        bits2 = bin(num2).count('1')
        bits1 = bin(num1).count('1')
        res = 0
        for i in range(31, -1, -1):
            if (num1 >> i) & 1:
                if bits2 > 0:
                    res |= (1 << i)
                    bits2 -= 1
        for i in range(32):
            if bits2 > 0 and not ((res >> i) & 1):
                res |= (1 << i)
                bits2 -= 1
        return res