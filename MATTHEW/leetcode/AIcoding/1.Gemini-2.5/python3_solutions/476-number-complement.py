class Solution:
    def findComplement(self, num: int) -> int:
        n_bits = num.bit_length()
        mask = (1 << n_bits) - 1
        return num ^ mask