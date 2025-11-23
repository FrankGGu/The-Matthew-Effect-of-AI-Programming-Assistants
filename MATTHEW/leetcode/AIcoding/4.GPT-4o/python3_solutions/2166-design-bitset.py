class Bitset:

    def __init__(self, size: int):
        self.size = size
        self.bits = [0] * size
        self.flip_count = 0
        self.ones_count = 0
        self.flipped = False

    def fix(self, idx: int) -> None:
        if self.flipped:
            if self.bits[idx] == 0:
                self.bits[idx] = 1
                self.ones_count -= 1
        else:
            if self.bits[idx] == 0:
                self.bits[idx] = 1
                self.ones_count += 1

    def unfix(self, idx: int) -> None:
        if self.flipped:
            if self.bits[idx] == 1:
                self.bits[idx] = 0
                self.ones_count += 1
        else:
            if self.bits[idx] == 1:
                self.bits[idx] = 0
                self.ones_count -= 1

    def flip(self) -> None:
        self.flipped = not self.flipped
        self.ones_count = self.size - self.ones_count

    def all(self) -> bool:
        return self.ones_count == self.size if not self.flipped else self.ones_count == 0

    def one(self) -> bool:
        return self.ones_count > 0 if not self.flipped else self.ones_count < self.size

    def count(self) -> int:
        return self.ones_count if not self.flipped else self.size - self.ones_count

    def toString(self) -> str:
        if self.flipped:
            return ''.join('0' if self.bits[i] == 1 else '1' for i in range(self.size))
        return ''.join(str(self.bits[i]) for i in range(self.size))