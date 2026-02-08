class MechanicalAccumulator:
    def __init__(self):
        self.total = 0

    def add(self, x: int) -> None:
        self.total += x

    def get(self) -> int:
        return self.total