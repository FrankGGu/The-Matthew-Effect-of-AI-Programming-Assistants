class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1
        if n > 10:
            n = 10

        count = 9
        unique_digits = 9

        for i in range(1, n):
            count *= unique_digits
            unique_digits -= 1

        return count + 1