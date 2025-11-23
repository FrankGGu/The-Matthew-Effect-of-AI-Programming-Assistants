class MapSum:

    def __init__(self):
        self.map = {}
        self.trie = {}

    def insert(self, key: str, val: int) -> None:
        diff = val - self.map.get(key, 0)
        self.map[key] = val
        node = self.trie
        for char in key:
            if char not in node:
                node[char] = {"sum": 0}
            node = node[char]
            node["sum"] = node.get("sum", 0) + diff

    def sum(self, prefix: str) -> int:
        node = self.trie
        for char in prefix:
            if char not in node:
                return 0
            node = node[char]
        return node.get("sum", 0)