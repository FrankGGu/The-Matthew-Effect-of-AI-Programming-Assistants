class Solution:
    def maxNonOverlapping(self, intervals: list[list[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        count = 0
        end = float('-inf')
        for interval in intervals:
            if interval[0] >= end:
                count += 1
                end = interval[1]
        return count