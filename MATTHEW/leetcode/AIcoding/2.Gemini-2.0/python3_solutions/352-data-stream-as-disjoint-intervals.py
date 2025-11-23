import bisect

class SummaryRanges:

    def __init__(self):
        self.intervals = []

    def addNum(self, value: int) -> None:
        idx = bisect.bisect_left(self.intervals, [value, float('inf')])

        if idx > 0 and self.intervals[idx - 1][1] >= value:
            return

        if idx < len(self.intervals) and self.intervals[idx][0] <= value:
            return

        start = value
        end = value

        if idx > 0 and self.intervals[idx - 1][1] == value - 1:
            start = self.intervals[idx - 1][0]
            self.intervals.pop(idx - 1)
            idx -= 1

        if idx < len(self.intervals) and self.intervals[idx][0] == value + 1:
            end = self.intervals[idx][1]
            self.intervals.pop(idx)

        self.intervals.insert(idx, [start, end])

    def getIntervals(self) -> list[list[int]]:
        return self.intervals