class SummaryRanges:

    def __init__(self):
        self.intervals = []

    def addNum(self, value: int) -> None:
        new_interval = [value, value]
        i = 0
        while i < len(self.intervals):
            if self.intervals[i][1] + 1 < new_interval[0]:
                i += 1
            elif self.intervals[i][0] > new_interval[1] + 1:
                break
            else:
                new_interval[0] = min(new_interval[0], self.intervals[i][0])
                new_interval[1] = max(new_interval[1], self.intervals[i][1])
                self.intervals.pop(i)

        self.intervals.insert(i, new_interval)

    def getIntervals(self) -> List[List[int]]:
        return self.intervals