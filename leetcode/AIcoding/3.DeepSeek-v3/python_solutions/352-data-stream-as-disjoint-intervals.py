class SummaryRanges:

    def __init__(self):
        self.intervals = []

    def addNum(self, value: int) -> None:
        left, right = 0, len(self.intervals) - 1
        while left <= right:
            mid = (left + right) // 2
            if self.intervals[mid][0] <= value <= self.intervals[mid][1]:
                return
            elif self.intervals[mid][0] > value:
                right = mid - 1
            else:
                left = mid + 1

        pos = left
        self.intervals.insert(pos, [value, value])

        if pos + 1 < len(self.intervals) and value + 1 == self.intervals[pos + 1][0]:
            self.intervals[pos][1] = self.intervals[pos + 1][1]
            self.intervals.pop(pos + 1)

        if pos - 1 >= 0 and self.intervals[pos - 1][1] + 1 == value:
            self.intervals[pos - 1][1] = self.intervals[pos][1]
            self.intervals.pop(pos)

    def getIntervals(self) -> List[List[int]]:
        return self.intervals