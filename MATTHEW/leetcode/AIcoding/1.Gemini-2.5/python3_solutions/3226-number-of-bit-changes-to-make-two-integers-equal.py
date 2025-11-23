class Solution:
    def numberOfBitChanges(self, n: int, k: int) -> int:
        xor_result = n ^ k
        return bin(xor_result).count('1')