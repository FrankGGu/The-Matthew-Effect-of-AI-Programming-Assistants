class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        if dividend == -2**31 and divisor == -1:
            return 2**31 - 1

        negative = (dividend < 0) != (divisor < 0)
        dividend, divisor = abs(dividend), abs(divisor)
        res = 0

        while dividend >= divisor:
            temp, i = divisor, 1
            while dividend >= temp << 1:
                temp <<= 1
                i <<= 1
            dividend -= temp
            res += i

        if negative:
            res = -res

        return max(-2**31, min(res, 2**31 - 1))