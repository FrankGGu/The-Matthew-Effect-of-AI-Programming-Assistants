class MyCalendarThree:

    def __init__(self):
        self.timeline = {}

    def book(self, start: int, end: int) -> int:
        self.timeline[start] = self.timeline.get(start, 0) + 1
        self.timeline[end] = self.timeline.get(end, 0) - 1

        active_events = 0
        max_overlap = 0
        sorted_keys = sorted(self.timeline.keys())

        for key in sorted_keys:
            active_events += self.timeline[key]
            max_overlap = max(max_overlap, active_events)

        return max_overlap