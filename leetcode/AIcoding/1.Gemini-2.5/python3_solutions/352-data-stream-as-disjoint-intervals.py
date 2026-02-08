import bisect

class SummaryRanges:

    def __init__(self):
        self.intervals = [] # List of [start, end] intervals, kept sorted by start

    def addNum(self, val: int) -> None:
        # Find the insertion point for [val, val]
        # bisect_left returns an index 'idx' such that all elements in self.intervals[:idx] are < [val, val]
        # and all elements in self.intervals[idx:] are >= [val, val].
        # For interval comparison, it compares by start, then by end.
        idx = bisect.bisect_left(self.intervals, [val, val])

        # Case 1: val is already covered by an existing interval
        # Check the interval immediately before the insertion point (if it exists)
        if idx > 0 and self.intervals[idx-1][0] <= val <= self.intervals[idx-1][1]:
            return # val is already in an interval, do nothing

        # Check the interval at the insertion point (if it exists)
        # This covers cases where val falls into self.intervals[idx] or val is self.intervals[idx][0]
        if idx < len(self.intervals) and self.intervals[idx][0] <= val <= self.intervals[idx][1]:
            return # val is already in an interval, do nothing

        # Determine merge possibilities
        can_merge_prev = (idx > 0 and self.intervals[idx-1][1] + 1 == val)
        can_merge_next = (idx < len(self.intervals) and self.intervals[idx][0] - 1 == val)

        if can_merge_prev and can_merge_next:
            # Case 4: Merge with both previous and next intervals
            # Extend the previous interval to cover the next interval's end
            self.intervals[idx-1][1] = self.intervals[idx][1]
            # Remove the next interval
            self.intervals.pop(idx)
        elif can_merge_prev:
            # Case 2: Merge with previous interval only
            # Extend the previous interval to include val
            self.intervals[idx-1][1] = val
        elif can_merge_next:
            # Case 3: Merge with next interval only
            # Extend the next interval to include val
            self.intervals[idx][0] = val
        else:
            # Case 1 (not covered): No merge possible, insert new interval [val, val]
            self.intervals.insert(idx, [val, val])

    def getIntervals(self) -> list[list[int]]:
        return self.intervals