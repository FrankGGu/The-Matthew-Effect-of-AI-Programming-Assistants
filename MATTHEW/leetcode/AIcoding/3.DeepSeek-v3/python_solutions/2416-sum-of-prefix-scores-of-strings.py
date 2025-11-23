class TrieNode:
    def __init__(self):
        self.children = {}
        self.count = 0

class Solution:
    def sumPrefixScores(self, words: List[str]) -> List[int]:
        root = TrieNode()

        for word in words:
            node = root
            for c in word:
                if c not in node.children:
                    node.children[c] = TrieNode()
                node = node.children[c]
                node.count += 1

        res = []
        for word in words:
            node = root
            total = 0
            for c in word:
                node = node.children[c]
                total += node.count
            res.append(total)

        return res