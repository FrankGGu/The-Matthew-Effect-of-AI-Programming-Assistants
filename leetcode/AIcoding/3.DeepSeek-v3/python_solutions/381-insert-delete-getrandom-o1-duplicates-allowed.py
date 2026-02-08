import random
from collections import defaultdict

class RandomizedCollection:

    def __init__(self):
        self.list = []
        self.index_map = defaultdict(set)

    def insert(self, val: int) -> bool:
        self.index_map[val].add(len(self.list))
        self.list.append(val)
        return len(self.index_map[val]) == 1

    def remove(self, val: int) -> bool:
        if not self.index_map[val]:
            return False
        last_element = self.list[-1]
        idx_to_remove = self.index_map[val].pop()
        self.list[idx_to_remove] = last_element
        self.index_map[last_element].add(idx_to_remove)
        self.index_map[last_element].discard(len(self.list) - 1)
        self.list.pop()
        return True

    def getRandom(self) -> int:
        return random.choice(self.list)