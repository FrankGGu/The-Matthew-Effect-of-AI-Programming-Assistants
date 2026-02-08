class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1
        if n == 1:
            return 10

        count = 10
        unique_digits = 9
        available_numbers = 9

        for i in range(2, n + 1):
            unique_digits *= available_numbers
            count += unique_digits
            available_numbers -= 1

        return count