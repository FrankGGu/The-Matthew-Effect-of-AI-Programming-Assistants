class Solution:
    def dayOfYear(self, date: str) -> int:
        year, month, day = map(int, date.split('-'))
        days_in_month = [31, 28 + (1 if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0) else 0), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        return sum(days_in_month[:month - 1]) + day