from datetime import date

class Solution:
    def daysBetweenDates(self, date1: str, date2: str) -> int:
        y1, m1, d1 = map(int, date1.split('-'))
        y2, m2, d2 = map(int, date2.split('-'))

        d_obj1 = date(y1, m1, d1)
        d_obj2 = date(y2, m2, d2)

        return abs((d_obj2 - d_obj1).days)