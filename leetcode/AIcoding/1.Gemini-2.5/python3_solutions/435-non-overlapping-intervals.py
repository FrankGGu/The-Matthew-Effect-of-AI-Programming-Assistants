class Solution:
    def eraseOverlapIntervals(self, intervals: list[list[int]]) -> int:
        if not intervals:
            return 0

        # Sort intervals by their end times
        intervals.sort(key=lambda x: x[1])

        end_time = -float('inf')
        non_overlapping_count = 0

        for interval in intervals:
            start, end = interval
            # If the current interval does not overlap with the last chosen non-overlapping interval
            if start >= end_time:
                non_overlapping_count += 1
                end_time = end

        # The number of intervals to remove is the total number of intervals
        # minus the maximum number of non-overlapping intervals.
        return len(intervals) - non_overlapping_count