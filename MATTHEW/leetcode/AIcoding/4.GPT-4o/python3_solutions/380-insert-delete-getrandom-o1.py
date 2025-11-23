import random

class RandomizedSet:

    def __init__(self):
        self.data = {}
        self.list = []

    def insert(self, val: int) -> bool:
        if val in self.data:
            return False
        self.data[val] = len(self.list)
        self.list.append(val)
        return True

    def remove(self, val: int) -> bool:
        if val not in self.data:
            return False
        index = self.data[val]
        last_element = self.list[-1]
        self.list[index] = last_element
        self.data[last_element] = index
        self.list.pop()
        del self.data[val]
        return True

    def getRandom(self) -> int:
        return random.choice(self.list)