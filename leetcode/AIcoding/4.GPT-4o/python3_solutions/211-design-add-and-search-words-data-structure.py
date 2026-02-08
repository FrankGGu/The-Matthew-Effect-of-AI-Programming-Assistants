class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False

class WordDictionary:
    def __init__(self):
        self.root = TrieNode()

    def addWord(self, word: str) -> None:
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True

    def search(self, word: str) -> bool:
        def search_in_node(word, node):
            if not word:
                return node.is_end_of_word
            if word[0] == '.':
                for child in node.children.values():
                    if search_in_node(word[1:], child):
                        return True
                return False
            if word[0] not in node.children:
                return False
            return search_in_node(word[1:], node.children[word[0]])

        return search_in_node(word, self.root)