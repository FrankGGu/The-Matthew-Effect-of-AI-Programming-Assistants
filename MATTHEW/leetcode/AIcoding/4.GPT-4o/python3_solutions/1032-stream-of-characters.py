class StreamChecker:

    def __init__(self, words: List[str]):
        self.trie = {}
        self.end = '#'
        for word in words:
            node = self.trie
            for char in reversed(word):
                if char not in node:
                    node[char] = {}
                node = node[char]
            node[self.end] = True
        self.stream = []

    def query(self, letter: str) -> bool:
        self.stream.append(letter)
        node = self.trie
        for char in reversed(self.stream):
            if char not in node:
                return False
            node = node[char]
            if self.end in node:
                return True
        return False