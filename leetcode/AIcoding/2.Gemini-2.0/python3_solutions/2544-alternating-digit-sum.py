class Solution:
    def alternateDigitSum(self, n: int) -> int:
        s = str(n)
        res = 0
        sign = 1
        for digit in s:
            res += sign * int(digit)
            sign *= -1
        return res