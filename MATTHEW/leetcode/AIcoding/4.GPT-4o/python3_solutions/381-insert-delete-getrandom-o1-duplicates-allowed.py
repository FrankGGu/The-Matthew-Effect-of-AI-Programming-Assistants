import random
from collections import defaultdict

class RandomizedCollection:

    def __init__(self):
        self.index_map = defaultdict(set)
        self.values = []

    def insert(self, val: int) -> bool:
        self.values.append(val)
        self.index_map[val].add(len(self.values) - 1)
        return len(self.index_map[val]) == 1

    def remove(self, val: int) -> bool:
        if val not in self.index_map or not self.index_map[val]:
            return False
        idx_to_remove = self.index_map[val].pop()
        last_val = self.values[-1]
        self.values[idx_to_remove] = last_val
        self.index_map[last_val].add(idx_to_remove)
        self.index_map[last_val].discard(len(self.values) - 1)
        self.values.pop()
        if not self.index_map[val]:
            del self.index_map[val]
        return True

    def getRandom(self) -> int:
        return random.choice(self.values)