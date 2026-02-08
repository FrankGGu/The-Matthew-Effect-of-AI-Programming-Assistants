class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_word = False

class StreamChecker:

    def __init__(self, words):
        self.trie = TrieNode()
        for word in words:
            self.add_word(word)
        self.stream = ""

    def add_word(self, word):
        node = self.trie
        for char in reversed(word):
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_word = True

    def query(self, letter):
        self.stream = letter + self.stream
        node = self.trie
        for char in self.stream:
            if char not in node.children:
                return False
            node = node.children[char]
            if node.is_word:
                return True
        return False