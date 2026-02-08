class Solution:
    def alternateDigitSum(self, n: int) -> int:
        s = str(n)
        total_sum = 0
        sign = 1
        for digit_char in s:
            digit = int(digit_char)
            total_sum += sign * digit
            sign *= -1
        return total_sum