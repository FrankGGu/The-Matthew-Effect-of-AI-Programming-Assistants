class Solution:
    def totalMoney(self, n: int) -> int:
        weeks = n // 7
        days = n % 7
        return weeks * (28 + 7 * (weeks - 1)) + days * (weeks + 1) + days * (days - 1) // 2