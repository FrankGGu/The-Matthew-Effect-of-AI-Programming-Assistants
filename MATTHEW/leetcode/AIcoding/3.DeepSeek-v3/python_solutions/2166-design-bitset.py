class Bitset:

    def __init__(self, size: int):
        self.size = size
        self.bits = [0] * size
        self.flipped = False
        self.count_one = 0

    def fix(self, idx: int) -> None:
        if not self.flipped:
            if self.bits[idx] == 0:
                self.bits[idx] = 1
                self.count_one += 1
        else:
            if self.bits[idx] == 1:
                self.bits[idx] = 0
                self.count_one += 1

    def unfix(self, idx: int) -> None:
        if not self.flipped:
            if self.bits[idx] == 1:
                self.bits[idx] = 0
                self.count_one -= 1
        else:
            if self.bits[idx] == 0:
                self.bits[idx] = 1
                self.count_one -= 1

    def flip(self) -> None:
        self.flipped = not self.flipped
        self.count_one = self.size - self.count_one

    def all(self) -> bool:
        return self.count_one == self.size

    def one(self) -> bool:
        return self.count_one > 0

    def count(self) -> int:
        return self.count_one

    def toString(self) -> str:
        res = []
        for bit in self.bits:
            if not self.flipped:
                res.append(str(bit))
            else:
                res.append(str(1 - bit))
        return ''.join(res)