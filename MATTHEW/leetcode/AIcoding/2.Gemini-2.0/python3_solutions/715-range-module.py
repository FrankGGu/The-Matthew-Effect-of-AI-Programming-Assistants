class RangeModule:

    def __init__(self):
        self.ranges = []

    def addRange(self, left: int, right: int) -> None:
        new_ranges = []
        i = 0
        while i < len(self.ranges) and self.ranges[i][1] < left:
            new_ranges.append(self.ranges[i])
            i += 1

        while i < len(self.ranges) and self.ranges[i][0] <= right:
            left = min(left, self.ranges[i][0])
            right = max(right, self.ranges[i][1])
            i += 1

        new_ranges.append([left, right])

        while i < len(self.ranges):
            new_ranges.append(self.ranges[i])
            i += 1

        self.ranges = new_ranges

    def queryRange(self, left: int, right: int) -> bool:
        l, r = 0, len(self.ranges) - 1
        while l <= r:
            mid = (l + r) // 2
            if self.ranges[mid][0] <= left and self.ranges[mid][1] >= right:
                return True
            elif self.ranges[mid][1] < left:
                l = mid + 1
            else:
                r = mid - 1
        return False

    def removeRange(self, left: int, right: int) -> None:
        new_ranges = []
        i = 0
        while i < len(self.ranges) and self.ranges[i][1] <= left:
            new_ranges.append(self.ranges[i])
            i += 1

        while i < len(self.ranges) and self.ranges[i][0] < right:
            if self.ranges[i][0] < left:
                new_ranges.append([self.ranges[i][0], left])
            if self.ranges[i][1] > right:
                new_ranges.append([right, self.ranges[i][1]])
            i += 1

        while i < len(self.ranges):
            new_ranges.append(self.ranges[i])
            i += 1

        self.ranges = new_ranges