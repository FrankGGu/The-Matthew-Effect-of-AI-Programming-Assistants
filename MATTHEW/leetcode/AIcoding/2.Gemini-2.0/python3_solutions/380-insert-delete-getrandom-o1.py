import random

class RandomizedSet:

    def __init__(self):
        self.items = []
        self.index_map = {}

    def insert(self, val: int) -> bool:
        if val in self.index_map:
            return False
        self.items.append(val)
        self.index_map[val] = len(self.items) - 1
        return True

    def remove(self, val: int) -> bool:
        if val not in self.index_map:
            return False
        index = self.index_map[val]
        last_element = self.items[-1]
        self.items[index] = last_element
        self.index_map[last_element] = index
        self.items.pop()
        del self.index_map[val]
        return True

    def getRandom(self) -> int:
        return random.choice(self.items)