class Solution:
    class TrieNode:
        def __init__(self):
            self.children = {}
            self.is_end_of_word = False

    class Trie:
        def __init__(self):
            self.root = Solution.TrieNode()

        def insert(self, word: str) -> None:
            node = self.root
            for char in word:
                if char not in node.children:
                    node.children[char] = Solution.TrieNode()
                node = node.children[char]
            node.is_end_of_word = True

        def search_shortest_root(self, word: str) -> str:
            node = self.root
            current_prefix_chars = []
            for char in word:
                if char not in node.children:
                    break
                node = node.children[char]
                current_prefix_chars.append(char)
                if node.is_end_of_word:
                    return "".join(current_prefix_chars)
            return ""

    def replaceWords(self, dictionary: list[str], sentence: str) -> str:
        trie = self.Trie()
        for root in dictionary:
            trie.insert(root)

        words = sentence.split(' ')
        result_words = []

        for word in words:
            shortest_root = trie.search_shortest_root(word)
            if shortest_root:
                result_words.append(shortest_root)
            else:
                result_words.append(word)

        return " ".join(result_words)