import random

class Solution:

    def __init__(self, nRows: int, nCols: int):
        self.total = nRows * nCols
        self.nRows = nRows
        self.nCols = nCols
        self.map = {}

    def flip(self) -> List[int]:
        idx = random.randint(0, self.total - 1)
        if idx in self.map:
            idx = self.map[idx]
        self.map[idx] = self.map.get(self.total - 1, self.total - 1)
        self.total -= 1
        return [idx // self.nCols, idx % self.nCols]

    def reset(self) -> None:
        self.total = self.nRows * self.nCols
        self.map.clear()