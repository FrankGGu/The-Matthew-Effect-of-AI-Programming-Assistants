class Solution:
    def convertDate(self, date: str) -> str:
        month, day, year = map(int, date.split('-'))
        return f"{year:04b}{month:05b}{day:05b}"