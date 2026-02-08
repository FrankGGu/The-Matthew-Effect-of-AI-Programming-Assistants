class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        n = len(binary)
        if '0' not in binary:
            return binary
        first_zero = binary.find('0')
        count_ones = binary.count('1', first_zero)
        res = ['1'] * n
        res[n - 1 - count_ones] = '0'
        return ''.join(res)