import random

class Solution:

    def __init__(self, n: int, blacklist: list[int]):
        self.size = n - len(blacklist)
        self.mapping = {}
        blacklist_set = set(blacklist)
        last = n - 1
        for b in blacklist:
            if b < self.size:
                while last in blacklist_set:
                    last -= 1
                self.mapping[b] = last
                last -= 1

    def pick(self) -> int:
        index = random.randint(0, self.size - 1)
        return self.mapping.get(index, index)