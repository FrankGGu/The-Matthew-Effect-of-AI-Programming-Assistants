class Solution:
    def isHarshad(self, x: int) -> bool:
        original = x
        sum_digits = 0
        while x > 0:
            sum_digits += x % 10
            x //= 10
        return sum_digits != 0 and original % sum_digits == 0