class Accumulator:

    def __init__(self):
        self.total = 0

    def add(self, num: int) -> None:
        self.total += num

    def get(self) -> int:
        return self.total

    def reset(self) -> None:
        self.total = 0