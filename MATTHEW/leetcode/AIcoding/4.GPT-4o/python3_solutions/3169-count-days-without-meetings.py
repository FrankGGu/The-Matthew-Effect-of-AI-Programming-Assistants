class Solution:
    def countDaysTogether(self, arriveAlice: str, leaveAlice: str, arriveBob: str, leaveBob: str) -> int:
        def to_days(date):
            month, day = map(int, date.split('-'))
            return (month - 1) * 31 + day

        startAlice = to_days(arriveAlice)
        endAlice = to_days(leaveAlice)
        startBob = to_days(arriveBob)
        endBob = to_days(leaveBob)

        start = max(startAlice, startBob)
        end = min(endAlice, endBob)

        return max(0, end - start + 1)