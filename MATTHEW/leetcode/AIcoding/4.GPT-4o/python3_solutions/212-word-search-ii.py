class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True

class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        if not board or not board[0]: return []
        self.m, self.n = len(board), len(board[0])
        self.result = set()
        self.trie = Trie()

        for word in words:
            self.trie.insert(word)

        def backtrack(x, y, node, path):
            if node.is_end:
                self.result.add(path)
                node.is_end = False

            if x < 0 or x >= self.m or y < 0 or y >= self.n or board[x][y] == '#':
                return

            char = board[x][y]
            if char not in node.children:
                return

            board[x][y] = '#'  # mark as visited
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                backtrack(x + dx, y + dy, node.children[char], path + char)
            board[x][y] = char  # unmark

        for i in range(self.m):
            for j in range(self.n):
                backtrack(i, j, self.trie.root, "")

        return list(self.result)