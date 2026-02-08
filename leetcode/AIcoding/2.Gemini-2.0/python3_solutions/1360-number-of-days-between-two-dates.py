import datetime

class Solution:
    def daysBetweenDates(self, date1: str, date2: str) -> int:
        date_obj1 = datetime.datetime.strptime(date1, "%Y-%m-%d").date()
        date_obj2 = datetime.datetime.strptime(date2, "%Y-%m-%d").date()
        return abs((date_obj1 - date_obj2).days)