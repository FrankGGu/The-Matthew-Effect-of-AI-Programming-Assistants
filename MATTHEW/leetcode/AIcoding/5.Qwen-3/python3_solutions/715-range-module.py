class RangeModule:

    def __init__(self):
        self.intervals = []

    def addRange(self, left: int, right: int) -> None:
        i = 0
        n = len(self.intervals)
        while i < n and self.intervals[i][1] < left:
            i += 1
        while i < n and self.intervals[i][0] <= right:
            left = min(left, self.intervals[i][0])
            right = max(right, self.intervals[i][1])
            self.intervals.pop(i)
            n -= 1
        self.intervals.insert(i, [left, right])

    def queryRange(self, left: int, right: int) -> bool:
        i = 0
        n = len(self.intervals)
        while i < n and self.intervals[i][1] < left:
            i += 1
        return i < n and self.intervals[i][0] <= left and self.intervals[i][1] >= right

    def removeRange(self, left: int, right: int) -> None:
        i = 0
        n = len(self.intervals)
        while i < n:
            if self.intervals[i][1] < left or self.intervals[i][0] > right:
                i += 1
            else:
                if self.intervals[i][0] < left:
                    self.intervals.insert(i, [self.intervals[i][0], left])
                    i += 1
                if self.intervals[i][1] > right:
                    self.intervals.insert(i + 1, [right, self.intervals[i][1]])
                    i += 1
                self.intervals.pop(i)
                n -= 1