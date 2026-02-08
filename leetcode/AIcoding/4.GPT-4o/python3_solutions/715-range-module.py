class RangeModule:

    def __init__(self):
        self.intervals = []

    def addRange(self, left: int, right: int) -> None:
        new_intervals = []
        i = 0
        while i < len(self.intervals) and self.intervals[i][1] < left:
            new_intervals.append(self.intervals[i])
            i += 1
        while i < len(self.intervals) and self.intervals[i][0] <= right:
            left = min(left, self.intervals[i][0])
            right = max(right, self.intervals[i][1])
            i += 1
        new_intervals.append([left, right])
        while i < len(self.intervals):
            new_intervals.append(self.intervals[i])
            i += 1
        self.intervals = new_intervals

    def queryRange(self, left: int, right: int) -> bool:
        i = 0
        while i < len(self.intervals):
            if self.intervals[i][0] < right and left < self.intervals[i][1]:
                return True
            i += 1
        return False

    def removeRange(self, left: int, right: int) -> None:
        new_intervals = []
        i = 0
        while i < len(self.intervals):
            if self.intervals[i][1] <= left:
                new_intervals.append(self.intervals[i])
            elif self.intervals[i][0] >= right:
                new_intervals.append(self.intervals[i])
            else:
                if self.intervals[i][0] < left:
                    new_intervals.append([self.intervals[i][0], left])
                if self.intervals[i][1] > right:
                    new_intervals.append([right, self.intervals[i][1]])
            i += 1
        self.intervals = new_intervals