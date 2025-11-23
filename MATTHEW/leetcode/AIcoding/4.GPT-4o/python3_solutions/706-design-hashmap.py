class MyHashMap:

    def __init__(self):
        self.size = 1000
        self.map = [[] for _ in range(self.size)]

    def put(self, key: int, value: int) -> None:
        index = key % self.size
        for i, (k, v) in enumerate(self.map[index]):
            if k == key:
                self.map[index][i] = (key, value)
                return
        self.map[index].append((key, value))

    def get(self, key: int) -> int:
        index = key % self.size
        for k, v in self.map[index]:
            if k == key:
                return v
        return -1

    def remove(self, key: int) -> None:
        index = key % self.size
        for i, (k, v) in enumerate(self.map[index]):
            if k == key:
                del self.map[index][i]
                return