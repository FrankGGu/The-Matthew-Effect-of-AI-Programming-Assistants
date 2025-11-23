class MyCalendarThree:

    def __init__(self):
        self.timeline = []

    def book(self, start: int, end: int) -> int:
        bisect.insort(self.timeline, (start, 1))
        bisect.insort(self.timeline, (end, -1))

        res = 0
        current = 0

        for _, delta in self.timeline:
            current += delta
            res = max(res, current)

        return res