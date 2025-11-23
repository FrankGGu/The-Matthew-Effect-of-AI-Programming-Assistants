class MyHashSet:

    def __init__(self):
        self.size = 1000
        self.table = [[] for _ in range(self.size)]

    def add(self, key: int) -> None:
        if key not in self.table[key % self.size]:
            self.table[key % self.size].append(key)

    def remove(self, key: int) -> None:
        if key in self.table[key % self.size]:
            self.table[key % self.size].remove(key)

    def contains(self, key: int) -> bool:
        return key in self.table[key % self.size]