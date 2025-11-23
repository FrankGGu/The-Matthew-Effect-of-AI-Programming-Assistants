class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        n = len(binary)
        zeros = []
        for i in range(n):
            if binary[i] == '0':
                zeros.append(i)
        if len(zeros) <= 1:
            return binary
        res = list(binary)
        k = zeros[0]
        for i in range(1, len(zeros)):
            res[zeros[i]] = '1'
        res[k] = '0'
        return ''.join(res)