class Solution:
    def dayOfTheWeek(self, day: int, month: int, year: int) -> str:
        days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        t = [0, 3, 2, 5, 0, 3, 5, 6, 1, 4, 6, 2]
        if month < 3:
            year -= 1
        day_of_week = (year + year // 4 - year // 100 + year // 400 + t[month - 1] + day) % 7
        return days[day_of_week]