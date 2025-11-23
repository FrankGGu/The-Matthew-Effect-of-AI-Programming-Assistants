class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        timePoints = sorted(int(t[:2]) * 60 + int(t[3:]) for t in timePoints)
        min_diff = float('inf')

        for i in range(len(timePoints)):
            diff = (timePoints[(i + 1) % len(timePoints)] - timePoints[i]) % 1440
            min_diff = min(min_diff, diff)

        return min_diff