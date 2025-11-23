class Solution:
    def dayOfYear(self, date: str) -> int:
        from datetime import datetime
        return int(datetime.strptime(date, "%Y-%m-%d").strftime("%j"))