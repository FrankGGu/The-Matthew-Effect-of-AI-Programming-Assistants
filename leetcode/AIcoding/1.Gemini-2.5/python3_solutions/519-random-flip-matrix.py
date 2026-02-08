import random

class Solution:

    def __init__(self, m: int, n: int):
        self.m = m
        self.n = n
        self.total_cells = m * n
        self.current_available = self.total_cells
        self.mapping = {}

    def flip(self) -> list[int]:
        rand_idx_in_range = random.randrange(self.current_available)

        actual_1d_idx_to_flip = self.mapping.get(rand_idx_in_range, rand_idx_in_range)

        last_available_1d_idx = self.mapping.get(self.current_available - 1, self.current_available - 1)

        self.mapping[rand_idx_in_range] = last_available_1d_idx

        self.mapping.pop(self.current_available - 1, None)

        self.current_available -= 1

        r = actual_1d_idx_to_flip // self.n
        c = actual_1d_idx_to_flip % self.n

        return [r, c]

    def reset(self) -> None:
        self.current_available = self.total_cells
        self.mapping = {}