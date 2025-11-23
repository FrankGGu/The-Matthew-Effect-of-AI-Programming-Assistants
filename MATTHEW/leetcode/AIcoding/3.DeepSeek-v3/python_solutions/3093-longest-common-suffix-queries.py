class TrieNode:
    def __init__(self):
        self.children = {}
        self.index = -1
        self.length = float('inf')

class Solution:
    def stringIndices(self, wordsContainer: List[str], wordsQuery: List[str]) -> List[int]:
        root = TrieNode()

        for idx, word in enumerate(wordsContainer):
            node = root
            if node.length > len(word):
                node.length = len(word)
                node.index = idx
            for c in reversed(word):
                if c not in node.children:
                    node.children[c] = TrieNode()
                node = node.children[c]
                if node.length > len(word):
                    node.length = len(word)
                    node.index = idx

        res = []
        for word in wordsQuery:
            node = root
            current_index = node.index
            for c in reversed(word):
                if c not in node.children:
                    break
                node = node.children[c]
                current_index = node.index
            res.append(current_index)

        return res