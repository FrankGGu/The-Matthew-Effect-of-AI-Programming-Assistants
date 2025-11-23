class LFUCache:

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = {}
        self.freq = {}
        self.min_freq = 0

    def get(self, key: int) -> int:
        if key in self.cache:
            val, freq = self.cache[key]
            self.freq[freq].discard(key)
            if not self.freq[freq]:
                del self.freq[freq]
                if self.min_freq == freq:
                    self.min_freq += 1
            freq += 1
            if freq not in self.freq:
                self.freq[freq] = set()
            self.freq[freq].add(key)
            self.cache[key] = (val, freq)
            return val
        return -1

    def put(self, key: int, value: int) -> None:
        if not self.capacity:
            return

        if key in self.cache:
            val, freq = self.cache[key]
            self.freq[freq].discard(key)
            if not self.freq[freq]:
                del self.freq[freq]
                if self.min_freq == freq:
                    self.min_freq += 1
            freq += 1
            if freq not in self.freq:
                self.freq[freq] = set()
            self.freq[freq].add(key)
            self.cache[key] = (value, freq)
        else:
            if len(self.cache) == self.capacity:
                evict_key = self.freq[self.min_freq].pop()
                del self.cache[evict_key]
                if not self.freq[self.min_freq]:
                    del self.freq[self.min_freq]
            self.cache[key] = (value, 1)
            if 1 not in self.freq:
                self.freq[1] = set()
            self.freq[1].add(key)
            self.min_freq = 1