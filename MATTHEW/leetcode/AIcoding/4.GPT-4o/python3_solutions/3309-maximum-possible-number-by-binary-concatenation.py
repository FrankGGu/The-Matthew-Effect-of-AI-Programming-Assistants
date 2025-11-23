class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        count_zeros = binary.count('0')
        if count_zeros == 0:
            return binary
        return '1' * (len(binary) - count_zeros) + '0' * (count_zeros)