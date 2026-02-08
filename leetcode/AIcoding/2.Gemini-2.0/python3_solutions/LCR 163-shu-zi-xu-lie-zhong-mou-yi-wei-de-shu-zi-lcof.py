class Solution:
    def findNthDigit(self, n: int) -> int:
        digits = 1
        count = 9
        while n > digits * count:
            n -= digits * count
            digits += 1
            count *= 10

        num = 10 ** (digits - 1) + (n - 1) // digits
        index = (n - 1) % digits

        return int(str(num)[index])