class MyHashSet:

    def __init__(self):
        self.bucket = [None] * 1000

    def add(self, key: int) -> None:
        index = key % 1000
        if self.bucket[index] is None:
            self.bucket[index] = set()
        self.bucket[index].add(key)

    def remove(self, key: int) -> None:
        index = key % 1000
        if self.bucket[index] is not None:
            self.bucket[index].discard(key)

    def contains(self, key: int) -> bool:
        index = key % 1000
        return self.bucket[index] is not None and key in self.bucket[index]