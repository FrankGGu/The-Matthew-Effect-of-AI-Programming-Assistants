class MyHashSet:

    def __init__(self):
        self.set = [False] * (10**6 + 1)

    def add(self, key: int) -> None:
        self.set[key] = True

    def remove(self, key: int) -> None:
        self.set[key] = False

    def contains(self, key: int) -> bool:
        return self.set[key]