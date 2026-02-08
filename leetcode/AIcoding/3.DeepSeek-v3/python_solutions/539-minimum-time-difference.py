class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        def convert(time):
            hh, mm = time.split(':')
            return int(hh) * 60 + int(mm)

        times = sorted([convert(t) for t in timePoints])
        min_diff = float('inf')
        for i in range(1, len(times)):
            min_diff = min(min_diff, times[i] - times[i-1])

        min_diff = min(min_diff, 1440 + times[0] - times[-1])
        return min_diff