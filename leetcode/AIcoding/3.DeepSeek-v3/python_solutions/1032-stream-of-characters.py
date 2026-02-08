class StreamChecker:

    def __init__(self, words: List[str]):
        self.trie = {}
        self.stream = []
        for word in words:
            node = self.trie
            for ch in reversed(word):
                if ch not in node:
                    node[ch] = {}
                node = node[ch]
            node['#'] = True

    def query(self, letter: str) -> bool:
        self.stream.append(letter)
        node = self.trie
        for ch in reversed(self.stream):
            if '#' in node:
                return True
            if ch not in node:
                return False
            node = node[ch]
        return '#' in node