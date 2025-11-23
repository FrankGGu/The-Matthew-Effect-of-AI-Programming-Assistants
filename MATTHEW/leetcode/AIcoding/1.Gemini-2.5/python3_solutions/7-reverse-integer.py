class Solution:
    def reverse(self, x: int) -> int:
        MAX_INT = 2**31 - 1
        MIN_INT = -2**31

        if x == 0:
            return 0

        sign = 1
        if x < 0:
            sign = -1
            x = -x

        reversed_x_str = str(x)[::-1]
        reversed_x_int = int(reversed_x_str)

        result = sign * reversed_x_int

        if result > MAX_INT or result < MIN_INT:
            return 0

        return result