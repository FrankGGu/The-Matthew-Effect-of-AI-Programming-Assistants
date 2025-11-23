class RLEIterator:

    def __init__(self, encoding: list[int]):
        self.encoding = encoding
        self.ptr = 0
        self.current_count = 0
        self.current_value = -1

    def next(self, n: int) -> int:
        while n > 0:
            if self.ptr >= len(self.encoding):
                return -1

            if self.current_count == 0:
                self.current_count = self.encoding[self.ptr]
                self.current_value = self.encoding[self.ptr + 1]
                self.ptr += 2

            if n >= self.current_count:
                n -= self.current_count
                self.current_count = 0
            else: # n < self.current_count
                self.current_count -= n
                n = 0

        return self.current_value