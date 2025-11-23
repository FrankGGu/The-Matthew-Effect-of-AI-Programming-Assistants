import re
from math import gcd

class Solution:
    def fractionAddition(self, expression: str) -> str:
        nums = list(map(int, re.findall(r'[+-]?\d+', expression)))
        numerator = 0
        denominator = 1
        for i in range(0, len(nums), 2):
            num = nums[i]
            den = nums[i+1]
            numerator = numerator * den + num * denominator
            denominator *= den
            common_divisor = gcd(numerator, denominator)
            numerator //= common_divisor
            denominator //= common_divisor
        if denominator < 0:
            numerator *= -1
            denominator *= -1
        return f"{numerator}/{denominator}"