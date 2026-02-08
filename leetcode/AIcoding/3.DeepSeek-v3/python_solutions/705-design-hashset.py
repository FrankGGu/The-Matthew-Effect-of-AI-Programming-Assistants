class MyHashSet:

    def __init__(self):
        self.size = 1000
        self.buckets = [[] for _ in range(self.size)]

    def _hash(self, key):
        return key % self.size

    def add(self, key: int) -> None:
        hash_key = self._hash(key)
        if key not in self.buckets[hash_key]:
            self.buckets[hash_key].append(key)

    def remove(self, key: int) -> None:
        hash_key = self._hash(key)
        if key in self.buckets[hash_key]:
            self.buckets[hash_key].remove(key)

    def contains(self, key: int) -> bool:
        hash_key = self._hash(key)
        return key in self.buckets[hash_key]