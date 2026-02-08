import random

class Solution:

    def __init__(self, n: int, blacklist: List[int]):
        self.m = n - len(blacklist)
        blacklist = set(blacklist)
        self.remap = {}
        j = self.m
        for b in blacklist:
            if b < self.m:
                while j in blacklist:
                    j += 1
                self.remap[b] = j
                j += 1

    def pick(self) -> int:
        r = random.randint(0, self.m - 1)
        return self.remap.get(r, r)