class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        MAX_INT = 2**31 - 1
        MIN_INT = -2**31

        if dividend == MIN_INT and divisor == -1:
            return MAX_INT

        negative = (dividend < 0) != (divisor < 0)

        abs_dividend = abs(dividend)
        abs_divisor = abs(divisor)

        quotient = 0

        while abs_dividend >= abs_divisor:
            temp_divisor = abs_divisor
            multiple = 1
            while (temp_divisor << 1) <= abs_dividend:
                temp_divisor <<= 1
                multiple <<= 1

            quotient += multiple
            abs_dividend -= temp_divisor

        if negative:
            return -quotient
        else:
            return quotient