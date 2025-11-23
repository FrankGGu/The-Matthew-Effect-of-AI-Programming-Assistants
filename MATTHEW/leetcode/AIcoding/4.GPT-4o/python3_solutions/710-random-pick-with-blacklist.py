import random

class Solution:

    def __init__(self, N: int, blacklist: List[int]):
        self.size = N - len(blacklist)
        self.blacklist = set(blacklist)
        self.mapping = {}
        blacklist.sort()
        j = 0
        for b in blacklist:
            while j < self.size and j in self.blacklist:
                j += 1
            if j < self.size:
                self.mapping[b] = j
                j += 1

    def pick(self) -> int:
        idx = random.randint(0, self.size - 1)
        return self.mapping.get(idx, idx)