class AllOne:

    def __init__(self):
        from collections import defaultdict
        self.key_count = {}
        self.count_keys = defaultdict(set)
        self.max_count = 0

    def inc(self, key: str) -> None:
        if key in self.key_count:
            old_count = self.key_count[key]
            self.count_keys[old_count].remove(key)
            if not self.count_keys[old_count]:
                del self.count_keys[old_count]
        else:
            old_count = 0

        new_count = old_count + 1
        self.key_count[key] = new_count
        self.count_keys[new_count].add(key)
        self.max_count = max(self.max_count, new_count)

    def dec(self, key: str) -> None:
        old_count = self.key_count[key]
        self.count_keys[old_count].remove(key)
        if not self.count_keys[old_count]:
            del self.count_keys[old_count]

        if old_count == 1:
            del self.key_count[key]
        else:
            new_count = old_count - 1
            self.key_count[key] = new_count
            self.count_keys[new_count].add(key)

    def getMaxKey(self) -> str:
        if not self.count_keys:
            return ""
        return next(iter(self.count_keys[self.max_count]))

    def getMinKey(self) -> str:
        if not self.count_keys:
            return ""
        return next(iter(self.count_keys[min(self.count_keys.keys())]))