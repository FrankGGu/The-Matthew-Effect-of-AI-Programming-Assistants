class MyCalendarThree:
    def __init__(self):
        self.timeline = []

    def book(self, start, end):
        self.timeline.append((start, 1))
        self.timeline.append((end, -1))
        self.timeline.sort()
        max_k = 0
        current_k = 0
        for time, delta in self.timeline:
            current_k += delta
            if current_k > max_k:
                max_k = current_k
        return max_k