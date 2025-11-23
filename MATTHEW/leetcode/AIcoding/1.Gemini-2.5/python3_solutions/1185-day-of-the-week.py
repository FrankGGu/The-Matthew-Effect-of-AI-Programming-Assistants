import datetime

class Solution:
    def dayOfTheWeek(self, day: int, month: int, year: int) -> str:
        days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

        date_obj = datetime.date(year, month, day)

        # datetime.date.weekday() returns an integer where Monday is 0 and Sunday is 6.
        weekday_index = date_obj.weekday()

        return days_of_week[weekday_index]