class Solution:
    def sumOfTheDigitsOfHarshadNumber(self, x: int) -> int:
        if x == 0:
            return -1
        sum_digits = sum(int(d) for d in str(abs(x)))
        if x % sum_digits == 0:
            return sum_digits
        else:
            return -1