import random

class RandomizedSet:

    def __init__(self):
        self.index_map = {}
        self.values = []

    def insert(self, val: int) -> bool:
        if val in self.index_map:
            return False
        self.index_map[val] = len(self.values)
        self.values.append(val)
        return True

    def remove(self, val: int) -> bool:
        if val not in self.index_map:
            return False
        last_element = self.values[-1]
        index_to_remove = self.index_map[val]
        self.values[index_to_remove] = last_element
        self.index_map[last_element] = index_to_remove
        self.values.pop()
        del self.index_map[val]
        return True

    def getRandom(self) -> int:
        return random.choice(self.values)