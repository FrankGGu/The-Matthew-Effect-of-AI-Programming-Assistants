class Solution:
    def countDaysBetweenDates(self, date1: str, date2: str) -> int:
        from datetime import datetime

        def parse_date(date_str):
            return datetime.strptime(date_str, "%Y-%m-%d")

        d1 = parse_date(date1)
        d2 = parse_date(date2)
        return abs((d2 - d1).days)