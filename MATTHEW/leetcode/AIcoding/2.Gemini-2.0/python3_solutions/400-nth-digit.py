class Solution:
    def findNthDigit(self, n: int) -> int:
        digits = 1
        base = 9
        while n > digits * base:
            n -= digits * base
            digits += 1
            base *= 10

        num = 10**(digits - 1) + (n - 1) // digits
        index = (n - 1) % digits
        return int(str(num)[index])