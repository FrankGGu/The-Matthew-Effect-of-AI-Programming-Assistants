class CountIntervals:

    def __init__(self):
        self.intervals = []
        self.count = 0

    def add(self, left: int, right: int) -> None:
        new_intervals = []
        new_left, new_right = left, right
        for interval in self.intervals:
            if interval[1] < new_left - 1:
                new_intervals.append(interval)
            elif interval[0] > new_right + 1:
                new_intervals.append(interval)
            else:
                new_left = min(new_left, interval[0])
                new_right = max(new_right, interval[1])
        new_intervals.append((new_left, new_right))
        new_intervals.sort()
        self.intervals = new_intervals
        self.count = sum(right - left + 1 for left, right in self.intervals)

    def count(self) -> int:
        return self.count