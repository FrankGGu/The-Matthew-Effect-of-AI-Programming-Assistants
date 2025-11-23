class Solution:
    def countDaysTogether(self, arriveAlice: str, leaveAlice: str, arriveBob: str, leaveBob: str) -> int:
        def date_to_days(date):
            month, day = map(int, date.split('-'))
            days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
            return sum(days_in_month[:month]) + day

        startAlice = date_to_days(arriveAlice)
        endAlice = date_to_days(leaveAlice)
        startBob = date_to_days(arriveBob)
        endBob = date_to_days(leaveBob)

        start = max(startAlice, startBob)
        end = min(endAlice, endBob)

        return max(0, end - start + 1)