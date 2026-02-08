class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        n = len(binary)
        num_zeros = binary.count('0')

        if num_zeros == 0:
            return binary

        return '1' * (n - 1) + '0'