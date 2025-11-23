class Solution:
    def removeCoveredIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: (x[0], -x[1]))
        count = 0
        right = 0
        for interval in intervals:
            if interval[1] > right:
                count += 1
                right = interval[1]
        return count