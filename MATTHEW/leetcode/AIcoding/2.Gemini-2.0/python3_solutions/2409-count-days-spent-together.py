class Solution:
    def countDaysTogether(self, arriveAlice: str, leaveAlice: str, arriveBob: str, leaveBob: str) -> int:
        days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        def date_to_days(date: str) -> int:
            month, day = map(int, date.split('-'))
            days = day
            for i in range(month - 1):
                days += days_in_month[i]
            return days

        arrive_a = date_to_days(arriveAlice)
        leave_a = date_to_days(leaveAlice)
        arrive_b = date_to_days(arriveBob)
        leave_b = date_to_days(leaveBob)

        start = max(arrive_a, arrive_b)
        end = min(leave_a, leave_b)

        return max(0, end - start + 1)