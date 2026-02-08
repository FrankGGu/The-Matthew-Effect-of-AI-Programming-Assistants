class Solution:
    def dayOfTheWeek(self, day: int, month: int, year: int) -> str:
        days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

        if month < 3:
            month += 12
            year -= 1

        K = year % 100
        J = year // 100

        h = (day + 13*(month+1)//5 + K + K//4 + J//4 - 2*J) % 7

        return days[h]