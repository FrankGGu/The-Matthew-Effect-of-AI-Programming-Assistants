import random

class Solution:

    def __init__(self, n: int, blacklist: list[int]):
        self.mapping = {}
        self.sz = n - len(blacklist)

        blacklist_set = set(blacklist)

        last_valid_num = n - 1

        for b in blacklist:
            if b < self.sz:
                while last_valid_num in blacklist_set:
                    last_valid_num -= 1
                self.mapping[b] = last_valid_num
                last_valid_num -= 1

    def pick(self) -> int:
        idx = random.randint(0, self.sz - 1)
        if idx in self.mapping:
            return self.mapping[idx]
        return idx