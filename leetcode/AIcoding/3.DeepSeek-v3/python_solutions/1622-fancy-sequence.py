class Fancy:

    def __init__(self):
        self.sequence = []
        self.ops = []
        self.mod = 10**9 + 7

    def append(self, val: int) -> None:
        self.sequence.append(val)
        self.ops.append((1, 0))

    def addAll(self, inc: int) -> None:
        self.ops.append((1, inc))

    def multAll(self, m: int) -> None:
        self.ops.append((m, 0))

    def getIndex(self, idx: int) -> int:
        if idx >= len(self.sequence):
            return -1
        a, b = 1, 0
        for i in range(idx, len(self.ops)):
            m, inc = self.ops[i]
            a = (a * m) % self.mod
            b = (b * m + inc) % self.mod
        return (self.sequence[idx] * a + b) % self.mod