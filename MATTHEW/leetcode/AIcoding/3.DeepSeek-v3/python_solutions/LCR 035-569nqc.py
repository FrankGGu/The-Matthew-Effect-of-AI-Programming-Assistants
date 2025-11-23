class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        def convert(time):
            hh, mm = map(int, time.split(':'))
            return hh * 60 + mm

        times = sorted([convert(t) for t in timePoints])
        min_diff = float('inf')
        n = len(times)

        for i in range(n):
            diff = (times[(i + 1) % n] - times[i]) % 1440
            min_diff = min(min_diff, diff)

        return min_diff