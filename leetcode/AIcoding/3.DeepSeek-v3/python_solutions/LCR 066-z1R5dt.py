class TrieNode:
    def __init__(self):
        self.children = {}
        self.value = 0

class MapSum:

    def __init__(self):
        self.root = TrieNode()
        self.keys = {}

    def insert(self, key: str, val: int) -> None:
        delta = val - self.keys.get(key, 0)
        self.keys[key] = val
        node = self.root
        for c in key:
            if c not in node.children:
                node.children[c] = TrieNode()
            node = node.children[c]
            node.value += delta

    def sum(self, prefix: str) -> int:
        node = self.root
        for c in prefix:
            if c not in node.children:
                return 0
            node = node.children[c]
        return node.value