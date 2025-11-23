class Bitset:
    def __init__(self, size: int):
        self.size = size
        self.bits = [0] * size
        self.ones = 0

    def fix(self, idx: int) -> None:
        if self.bits[idx] == 0:
            self.bits[idx] = 1
            self.ones += 1

    def unfix(self, idx: int) -> None:
        if self.bits[idx] == 1:
            self.bits[idx] = 0
            self.ones -= 1

    def flip(self) -> None:
        self.ones = self.size - self.ones
        for i in range(self.size):
            self.bits[i] ^= 1

    def all(self) -> bool:
        return self.ones == self.size

    def one(self) -> bool:
        return self.ones > 0

    def count(self) -> int:
        return self.ones

    def toString(self) -> str:
        return ''.join(map(str, self.bits))