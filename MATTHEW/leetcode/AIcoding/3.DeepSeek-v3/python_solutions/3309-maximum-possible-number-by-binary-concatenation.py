class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        n = len(binary)
        first_zero = -1
        zero_count = 0

        for i in range(n):
            if binary[i] == '0':
                if first_zero == -1:
                    first_zero = i
                zero_count += 1

        if zero_count <= 1:
            return binary

        res = ['1'] * n
        res[first_zero + zero_count - 1] = '0'
        return ''.join(res)