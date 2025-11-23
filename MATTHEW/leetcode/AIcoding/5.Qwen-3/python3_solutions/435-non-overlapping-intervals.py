class Solution:
    def eraseOverlapIntervals(self, intervals: List[Interval]) -> int:
        if not intervals:
            return 0
        intervals.sort(key=lambda x: x.end)
        count = 1
        last_end = intervals[0].end
        for interval in intervals[1:]:
            if interval.start >= last_end:
                count += 1
                last_end = interval.end
        return count