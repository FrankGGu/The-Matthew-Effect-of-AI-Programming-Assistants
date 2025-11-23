class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1

        count = 1
        available_digits = 9
        unique_digits = 9

        for i in range(1, min(n, 10) + 1):
            unique_digits *= available_digits
            count += unique_digits
            available_digits -= 1

        return count