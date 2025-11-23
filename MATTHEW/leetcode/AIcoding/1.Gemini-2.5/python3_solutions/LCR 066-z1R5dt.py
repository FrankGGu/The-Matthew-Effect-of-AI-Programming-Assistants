class TrieNode:
    def __init__(self):
        self.children = {}
        self.val_sum = 0

class MapSum:
    def __init__(self):
        self.root = TrieNode()
        self.key_values = {}

    def insert(self, key: str, val: int) -> None:
        old_val = self.key_values.get(key, 0)
        delta = val - old_val

        self.key_values[key] = val

        curr = self.root
        for char in key:
            if char not in curr.children:
                curr.children[char] = TrieNode()
            curr = curr.children[char]
            curr.val_sum += delta

    def sum(self, prefix: str) -> int:
        curr = self.root
        for char in prefix:
            if char not in curr.children:
                return 0
            curr = curr.children[char]
        return curr.val_sum