class Solution:
    def totalMoney(self, n: int) -> int:
        weeks = n // 7
        days = n % 7

        total = 0

        total += weeks * (28 + 7 * (weeks - 1)) // 2

        total += weeks * days + days * (days + 1) // 2

        return total