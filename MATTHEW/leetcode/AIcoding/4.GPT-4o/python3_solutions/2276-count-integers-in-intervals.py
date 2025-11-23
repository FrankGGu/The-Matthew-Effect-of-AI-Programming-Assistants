class CountIntervals:

    def __init__(self):
        self.intervals = []

    def add(self, left: int, right: int) -> None:
        self.intervals.append((left, right))
        self.intervals.sort()
        merged = []
        for start, end in self.intervals:
            if not merged or merged[-1][1] < start - 1:
                merged.append((start, end))
            else:
                merged[-1] = (merged[-1][0], max(merged[-1][1], end))
        self.intervals = merged

    def count(self) -> int:
        count = 0
        for start, end in self.intervals:
            count += end - start + 1
        return count