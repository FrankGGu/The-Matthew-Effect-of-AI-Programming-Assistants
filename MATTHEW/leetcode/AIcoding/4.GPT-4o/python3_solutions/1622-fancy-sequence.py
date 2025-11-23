class Fancy:
    def __init__(self):
        self.mod = 10**9 + 7
        self.num = []
        self.add = []
        self.mul = []
        self.base = 1

    def append(self, a: int) -> None:
        self.num.append(a)
        self.add.append(0)
        self.mul.append(1)

    def add_all(self, inc: int) -> None:
        self.base = (self.base * 1) % self.mod
        self.add[-1] = (self.add[-1] + inc) % self.mod

    def mult_all(self, m: int) -> None:
        self.base = (self.base * m) % self.mod
        self.add = [(x * m) % self.mod for x in self.add]
        self.add[-1] = (self.add[-1] * m) % self.mod

    def get_index(self, idx: int) -> int:
        if idx >= len(self.num):
            return -1
        return (self.num[idx] * self.base + self.add[idx]) % self.mod