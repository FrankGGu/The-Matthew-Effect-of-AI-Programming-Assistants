class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        if dividend == -2147483648 and divisor == -1:
            return 2147483647

        sign = (dividend > 0) ^ (divisor > 0)
        dividend = abs(dividend)
        divisor = abs(divisor)

        quotient = 0
        while dividend >= divisor:
            temp = divisor
            multiple = 1
            while dividend >= (temp << 1):
                if (temp << 1) > 2147483647:
                    break
                temp <<= 1
                multiple <<= 1
            dividend -= temp
            quotient += multiple

        if sign:
            quotient = -quotient

        return max(-2147483648, min(quotient, 2147483647))