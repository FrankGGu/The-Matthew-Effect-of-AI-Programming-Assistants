class Solution:
    def maximumOddBinaryNumber(self, s: str) -> str:
        count_ones = s.count('1')
        n = len(s)

        result = ['0'] * n

        # Place the last '1' to make it odd
        result[n - 1] = '1'

        # Place the remaining '1's at the beginning
        for i in range(count_ones - 1):
            result[i] = '1'

        return "".join(result)