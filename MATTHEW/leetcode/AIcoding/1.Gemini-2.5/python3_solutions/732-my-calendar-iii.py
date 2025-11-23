import collections

class MyCalendarThree:

    def __init__(self):
        self.times = collections.defaultdict(int)

    def book(self, start: int, end: int) -> int:
        self.times[start] += 1
        self.times[end] -= 1

        current_overlap = 0
        max_overlap = 0

        for time_point in sorted(self.times.keys()):
            current_overlap += self.times[time_point]
            max_overlap = max(max_overlap, current_overlap)

        return max_overlap