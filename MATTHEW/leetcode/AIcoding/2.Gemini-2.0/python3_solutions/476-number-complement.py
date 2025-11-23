class Solution:
    def findComplement(self, num: int) -> int:
        bit = 1
        while bit <= num:
            bit <<= 1
        return (bit - 1) ^ num