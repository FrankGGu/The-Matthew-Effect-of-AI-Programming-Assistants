class Solution:
    def dayOfYear(self, date: str) -> int:
        year = int(date[0:4])
        month = int(date[5:7])
        day = int(date[8:10])

        days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        # Check for leap year
        if (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0):
            days_in_month[2] = 29 # February in a leap year

        day_of_year_count = 0
        for i in range(1, month):
            day_of_year_count += days_in_month[i]

        day_of_year_count += day

        return day_of_year_count