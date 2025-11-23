class Solution:
    def reverse(self, x: int) -> int:
        sign = -1 if x < 0 else 1
        x = abs(x)
        reversed_x = 0
        while x > 0:
            digit = x % 10
            reversed_x = reversed_x * 10 + digit
            x //= 10

        reversed_x = sign * reversed_x

        if reversed_x < -2**31 or reversed_x > 2**31 - 1:
            return 0
        else:
            return reversed_x