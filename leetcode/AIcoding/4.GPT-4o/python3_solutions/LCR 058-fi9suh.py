class MyCalendar:

    def __init__(self):
        self.intervals = []

    def book(self, start: int, end: int) -> bool:
        for s, e in self.intervals:
            if start < e and end > s:
                return False
        self.intervals.append((start, end))
        return True