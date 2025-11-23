class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        flips = 0
        for i in range(32):
            mask = 1 << i
            a_bit = (a & mask) != 0
            b_bit = (b & mask) != 0
            c_bit = (c & mask) != 0

            if (a_bit | b_bit) == c_bit:
                continue
            if c_bit:
                flips += 1
            else:
                flips += (a_bit + b_bit)
        return flips