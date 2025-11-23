class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.queue = []
        self.sum = 0

    def next(self, val: int) -> float:
        self.queue.append(val)
        self.sum += val
        if len(self.queue) > self.size:
            self.sum -= self.queue.pop(0)
        return self.sum / len(self.queue)