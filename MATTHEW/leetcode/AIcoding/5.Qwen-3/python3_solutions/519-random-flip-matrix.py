class Solution:
    def __init__(self, m: int, n: int):
        self.m = m
        self.n = n
        self.total = m * n
        self.used = set()

    def flip(self) -> List[int]:
        import random
        while True:
            i = random.randint(0, self.m - 1)
            j = random.randint(0, self.n - 1)
            if (i, j) not in self.used:
                self.used.add((i, j))
                return [i, j]

    def reset(self) -> None:
        self.used.clear()