import random
from collections import defaultdict

class RandomizedSet:

    def __init__(self):
        self.nums = []
        self.indices = defaultdict(int)

    def insert(self, val: int) -> bool:
        if val in self.indices:
            return False
        self.nums.append(val)
        self.indices[val] = len(self.nums) - 1
        return True

    def remove(self, val: int) -> bool:
        if val not in self.indices:
            return False
        idx = self.indices[val]
        last = self.nums[-1]
        self.nums[idx] = last
        self.indices[last] = idx
        self.nums.pop()
        del self.indices[val]
        return True

    def getRandom(self) -> int:
        return random.choice(self.nums)