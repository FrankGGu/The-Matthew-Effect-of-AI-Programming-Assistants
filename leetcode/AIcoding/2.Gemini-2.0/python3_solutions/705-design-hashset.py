class MyHashSet:

    def __init__(self):
        self.capacity = 1000
        self.buckets = [[] for _ in range(self.capacity)]

    def add(self, key: int) -> None:
        bucket_index = key % self.capacity
        if key not in self.buckets[bucket_index]:
            self.buckets[bucket_index].append(key)

    def remove(self, key: int) -> None:
        bucket_index = key % self.capacity
        if key in self.buckets[bucket_index]:
            self.buckets[bucket_index].remove(key)

    def contains(self, key: int) -> bool:
        bucket_index = key % self.capacity
        return key in self.buckets[bucket_index]