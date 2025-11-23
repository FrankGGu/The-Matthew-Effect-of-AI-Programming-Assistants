class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        timePoints.sort()
        min_diff = float('inf')
        for i in range(1, len(timePoints)):
            h1, m1 = map(int, timePoints[i].split(':'))
            h2, m2 = map(int, timePoints[i-1].split(':'))
            diff = (h1 - h2) * 60 + (m1 - m2)
            min_diff = min(min_diff, diff)
        h1, m1 = map(int, timePoints[0].split(':'))
        h2, m2 = map(int, timePoints[-1].split(':'))
        diff = (h1 + 24 - h2) * 60 + (m1 - m2)
        min_diff = min(min_diff, diff)
        return min_diff