class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1
        res = 10
        unique_digits = 9
        available_numbers = 9
        for i in range(2, n + 1):
            if available_numbers == 0:
                break
            unique_digits *= available_numbers
            res += unique_digits
            available_numbers -= 1
        return res