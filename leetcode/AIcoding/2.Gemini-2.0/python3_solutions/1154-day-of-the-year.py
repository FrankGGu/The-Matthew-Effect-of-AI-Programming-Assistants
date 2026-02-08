class Solution:
    def dayOfYear(self, date: str) -> int:
        year, month, day = map(int, date.split('-'))
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
            days_in_month[2 - 1] = 29

        day_of_year = 0
        for i in range(month - 1):
            day_of_year += days_in_month[i]
        day_of_year += day

        return day_of_year