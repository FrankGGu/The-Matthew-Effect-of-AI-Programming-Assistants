class MyCalendarThree:

    def __init__(self):
        self.timeline = {}

    def book(self, start: int, end: int) -> int:
        self.timeline[start] = self.timeline.get(start, 0) + 1
        self.timeline[end] = self.timeline.get(end, 0) - 1

        active = 0
        max_active = 0
        for time in sorted(self.timeline):
            active += self.timeline[time]
            max_active = max(max_active, active)

        return max_active