import random

class Solution:

    def __init__(self, m: int, n: int):
        self.m = m
        self.n = n
        self.total = m * n
        self.map = {}
        self.reset()

    def flip(self) -> List[int]:
        self.total -= 1
        idx = random.randint(0, self.total)
        val = self.map.get(idx, idx)
        self.map[idx] = self.map.get(self.total, self.total)
        return [val // self.n, val % self.n]

    def reset(self) -> None:
        self.total = self.m * self.n
        self.map = {}