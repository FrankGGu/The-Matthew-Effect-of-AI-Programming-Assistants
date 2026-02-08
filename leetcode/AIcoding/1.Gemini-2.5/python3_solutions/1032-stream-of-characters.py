import collections

class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False

class StreamChecker:

    def __init__(self, words: List[str]):
        self.trie = TrieNode()
        self.max_word_len = 0

        for word in words:
            self.max_word_len = max(self.max_word_len, len(word))
            current_node = self.trie
            for char in reversed(word):
                if char not in current_node.children:
                    current_node.children[char] = TrieNode()
                current_node = current_node.children[char]
            current_node.is_end_of_word = True

        self.queries = collections.deque()

    def query(self, letter: str) -> bool:
        self.queries.appendleft(letter)

        if len(self.queries) > self.max_word_len:
            self.queries.pop()

        current_node = self.trie

        for char in self.queries:
            if char not in current_node.children:
                return False
            current_node = current_node.children[char]
            if current_node.is_end_of_word:
                return True

        return False