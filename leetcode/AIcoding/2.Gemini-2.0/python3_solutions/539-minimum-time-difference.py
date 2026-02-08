class Solution:
    def findMinDifference(self, timePoints: list[str]) -> int:
        minutes = []
        for time in timePoints:
            h, m = map(int, time.split(':'))
            minutes.append(h * 60 + m)

        minutes.sort()

        min_diff = float('inf')
        for i in range(len(minutes) - 1):
            min_diff = min(min_diff, minutes[i+1] - minutes[i])

        min_diff = min(min_diff, minutes[0] + 1440 - minutes[-1])

        return min_diff