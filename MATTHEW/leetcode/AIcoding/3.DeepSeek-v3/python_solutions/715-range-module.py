class RangeModule:

    def __init__(self):
        self.ranges = []

    def addRange(self, left: int, right: int) -> None:
        new_ranges = []
        inserted = False
        for start, end in self.ranges:
            if end < left:
                new_ranges.append((start, end))
            elif start > right:
                if not inserted:
                    new_ranges.append((left, right))
                    inserted = True
                new_ranges.append((start, end))
            else:
                left = min(left, start)
                right = max(right, end)
        if not inserted:
            new_ranges.append((left, right))
        self.ranges = new_ranges

    def queryRange(self, left: int, right: int) -> bool:
        low, high = 0, len(self.ranges) - 1
        while low <= high:
            mid = (low + high) // 2
            start, end = self.ranges[mid]
            if start <= left and end >= right:
                return True
            elif end < left:
                low = mid + 1
            else:
                high = mid - 1
        return False

    def removeRange(self, left: int, right: int) -> None:
        new_ranges = []
        for start, end in self.ranges:
            if end < left:
                new_ranges.append((start, end))
            elif start > right:
                new_ranges.append((start, end))
            else:
                if start < left:
                    new_ranges.append((start, left))
                if end > right:
                    new_ranges.append((right, end))
        self.ranges = new_ranges