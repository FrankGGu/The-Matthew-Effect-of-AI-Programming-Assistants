class MyCalendarTwo:

    def __init__(self):
        self.intervals = []
        self.overlaps = []

    def book(self, start: int, end: int) -> bool:
        for s, e in self.overlaps:
            if start < e and end > s:
                return False
        self.intervals.append((start, end))
        for s, e in self.intervals:
            if start < e and end > s:
                self.overlaps.append((max(start, s), min(end, e)))
        return True