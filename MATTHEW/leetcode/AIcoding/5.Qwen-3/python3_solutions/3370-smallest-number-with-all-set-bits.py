class Solution:
    def smallestNumber(self, n: int) -> int:
        if n == 0:
            return 0
        bits = []
        while n > 0:
            bits.append(n & 1)
            n >>= 1
        bits.reverse()
        result = 0
        for bit in bits:
            result = (result << 1) | bit
        return result