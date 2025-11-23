class RLEIterator:

    def __init__(self, A: List[int]):
        self.A = A
        self.index = 0
        self.remaining = 0

    def next(self, n: int) -> int:
        while n > 0:
            if self.remaining == 0:
                if self.index >= len(self.A):
                    return -1
                self.remaining = self.A[self.index]
                self.index += 1
            if n > self.remaining:
                n -= self.remaining
                self.remaining = 0
            else:
                self.remaining -= n
                return self.A[self.index - 1]
        return -1