class Solution:
    def maximumOddBinaryNumber(self, n: int) -> str:
        return '1' * (n // 2) + '0' * (n // 2) + '1'