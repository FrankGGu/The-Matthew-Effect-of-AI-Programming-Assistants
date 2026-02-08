class Solution:
    def removeCoveredIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: (x[0], -x[1]))
        count = 0
        end = 0

        for _, right in intervals:
            if right > end:
                count += 1
                end = right

        return count