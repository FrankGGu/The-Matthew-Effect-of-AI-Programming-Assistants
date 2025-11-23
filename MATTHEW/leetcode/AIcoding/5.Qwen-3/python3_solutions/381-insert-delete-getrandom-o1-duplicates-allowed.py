import random
from collections import defaultdict

class RandomizedCollection:

    def __init__(self):
        self.nums = []
        self.index_map = defaultdict(set)

    def insert(self, val: int) -> bool:
        index = len(self.nums)
        self.nums.append(val)
        self.index_map[val].add(index)
        return len(self.index_map[val]) == 1

    def remove(self, val: int) -> bool:
        if val not in self.index_map or not self.index_map[val]:
            return False
        index = self.index_map[val].pop()
        if index != len(self.nums) - 1:
            last_val = self.nums[-1]
            self.nums[index] = last_val
            self.index_map[last_val].remove(len(self.nums) - 1)
            self.index_map[last_val].add(index)
        self.nums.pop()
        return True

    def getRandom(self) -> int:
        return random.choice(self.nums)