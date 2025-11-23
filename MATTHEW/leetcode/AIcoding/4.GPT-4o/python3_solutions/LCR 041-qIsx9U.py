from collections import deque

class MovingAverage:
    def __init__(self, size: int):
        self.size = size
        self.queue = deque()
        self.total = 0.0

    def next(self, val: int) -> float:
        if len(self.queue) == self.size:
            self.total -= self.queue.popleft()
        self.queue.append(val)
        self.total += val
        return self.total / len(self.queue)