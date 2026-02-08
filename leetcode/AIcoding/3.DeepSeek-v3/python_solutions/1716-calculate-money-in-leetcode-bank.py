class Solution:
    def totalMoney(self, n: int) -> int:
        total = 0
        weeks = n // 7
        remaining_days = n % 7

        # Calculate full weeks
        total += 28 * weeks
        total += 7 * (weeks * (weeks - 1)) // 2

        # Calculate remaining days
        start = weeks + 1
        end = start + remaining_days - 1
        total += (start + end) * remaining_days // 2

        return total