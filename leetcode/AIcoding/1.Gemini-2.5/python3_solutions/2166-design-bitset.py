class Bitset:

    def __init__(self, size: int):
        self.size = size
        self.set_bits = set()
        self.unset_bits = set(range(size))
        self.ones_count = 0

    def fix(self, idx: int) -> None:
        if idx in self.unset_bits:
            self.unset_bits.remove(idx)
            self.set_bits.add(idx)
            self.ones_count += 1

    def unfix(self, idx: int) -> None:
        if idx in self.set_bits:
            self.set_bits.remove(idx)
            self.unset_bits.add(idx)
            self.ones_count -= 1

    def flip(self) -> None:
        self.set_bits, self.unset_bits = self.unset_bits, self.set_bits
        self.ones_count = self.size - self.ones_count

    def all(self) -> bool:
        return self.ones_count == self.size

    def one(self) -> bool:
        return self.ones_count > 0

    def count(self) -> int:
        return self.ones_count

    def toString(self) -> str:
        res = ['0'] * self.size
        for idx in self.set_bits:
            res[idx] = '1'
        return "".join(res)