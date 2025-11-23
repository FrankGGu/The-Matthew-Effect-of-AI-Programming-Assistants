class Solution:
    def sumOfTheDigits(self, x: int) -> int:
        s = 0
        while x > 0:
            s += x % 10
            x //= 10
        return s

    def isHarshad(self, x: int) -> bool:
        if x == 0:
            return False

        digit_sum = 0
        temp_x = x
        while temp_x > 0:
            digit_sum += temp_x % 10
            temp_x //= 10

        if digit_sum == 0:
            return False

        return x % digit_sum == 0