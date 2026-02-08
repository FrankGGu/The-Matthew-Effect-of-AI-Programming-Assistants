import random

class RandomizedCollection:

    def __init__(self):
        self.nums = []
        self.locs = {}

    def insert(self, val: int) -> bool:
        self.nums.append(val)
        if val not in self.locs:
            self.locs[val] = set()
        self.locs[val].add(len(self.nums) - 1)
        return len(self.locs[val]) == 1

    def remove(self, val: int) -> bool:
        if val not in self.locs or not self.locs[val]:
            return False

        idx = self.locs[val].pop()
        last_val = self.nums[-1]

        self.nums[idx] = last_val
        self.locs[last_val].add(idx)
        self.locs[last_val].discard(len(self.nums) - 1)

        if not self.locs[val]:
            del self.locs[val]

        self.nums.pop()
        return True

    def getRandom(self) -> int:
        return random.choice(self.nums)