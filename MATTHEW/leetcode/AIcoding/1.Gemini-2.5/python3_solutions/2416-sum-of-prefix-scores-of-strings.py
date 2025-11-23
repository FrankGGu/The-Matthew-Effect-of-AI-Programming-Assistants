class TrieNode:
    def __init__(self):
        self.children = {}
        self.count = 0

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word: str) -> None:
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
            node.count += 1

    def get_score(self, word: str) -> int:
        score = 0
        node = self.root
        for char in word:
            node = node.children[char]
            score += node.count
        return score

class Solution:
    def sumPrefixScores(self, words: list[str]) -> list[int]:
        trie = Trie()

        for word in words:
            trie.insert(word)

        result_scores = []
        for word in words:
            result_scores.append(trie.get_score(word))

        return result_scores