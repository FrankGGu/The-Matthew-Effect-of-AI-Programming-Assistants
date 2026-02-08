class Solution:
    def daysBetweenDates(self, date1: str, date2: str) -> int:
        def is_leap(year):
            if year % 4 != 0:
                return False
            elif year % 100 != 0:
                return True
            else:
                return year % 400 == 0

        def days_from_1971(date):
            year, month, day = map(int, date.split('-'))
            total = 0
            for y in range(1971, year):
                total += 366 if is_leap(y) else 365
            month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            if is_leap(year):
                month_days[1] = 29
            total += sum(month_days[:month-1])
            total += day
            return total

        return abs(days_from_1971(date1) - days_from_1971(date2))