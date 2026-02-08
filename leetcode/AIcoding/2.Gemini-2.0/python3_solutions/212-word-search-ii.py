class TrieNode:
    def __init__(self):
        self.children = {}
        self.word = None

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.word = word

class Solution:
    def findWords(self, board, words):
        trie = Trie()
        for word in words:
            trie.insert(word)

        rows = len(board)
        cols = len(board[0])
        visited = set()
        result = set()

        def dfs(row, col, node):
            if row < 0 or row >= rows or col < 0 or col >= cols or (row, col) in visited or board[row][col] not in node.children:
                return

            char = board[row][col]
            node = node.children[char]

            if node.word:
                result.add(node.word)

            visited.add((row, col))
            dfs(row + 1, col, node)
            dfs(row - 1, col, node)
            dfs(row, col + 1, node)
            dfs(row, col - 1, node)
            visited.remove((row, col))

        for row in range(rows):
            for col in range(cols):
                dfs(row, col, trie.root)

        return list(result)