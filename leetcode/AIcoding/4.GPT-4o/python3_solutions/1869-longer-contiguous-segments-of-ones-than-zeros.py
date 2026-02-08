class Solution:
    def checkZeroOnes(self, s: str) -> bool:
        ones = zeros = 0
        max_ones = max_zeros = 0

        for char in s:
            if char == '1':
                ones += 1
                max_zeros = max(max_zeros, zeros)
                zeros = 0
            else:
                zeros += 1
                max_ones = max(max_ones, ones)
                ones = 0

        max_ones = max(max_ones, ones)
        max_zeros = max(max_zeros, zeros)

        return max_ones > max_zeros