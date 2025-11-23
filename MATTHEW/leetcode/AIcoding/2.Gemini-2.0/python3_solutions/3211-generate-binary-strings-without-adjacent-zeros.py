class Solution:
    def generateBinaryStrings(self, n: int) -> int:
        mod = 10**9 + 7
        zeros = 1
        ones = 1
        for _ in range(n - 1):
            new_ones = (ones + zeros) % mod
            new_zeros = ones % mod
            ones = new_ones
            zeros = new_zeros
        return (ones + zeros) % mod