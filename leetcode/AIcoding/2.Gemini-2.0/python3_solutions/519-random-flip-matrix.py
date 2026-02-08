import random

class Solution:

    def __init__(self, m: int, n: int):
        self.m = m
        self.n = n
        self.total = m * n
        self.mapping = {}

    def flip(self) -> list[int]:
        rand_idx = random.randint(0, self.total - 1)
        self.total -= 1

        original_idx = self.mapping.get(rand_idx, rand_idx)

        self.mapping[rand_idx] = self.mapping.get(self.total, self.total)

        return [original_idx // self.n, original_idx % self.n]

    def reset(self) -> None:
        self.total = self.m * self.n
        self.mapping = {}