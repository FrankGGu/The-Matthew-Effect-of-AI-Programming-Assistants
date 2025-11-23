class TrieNode:
    def __init__(self):
        self.children = {}
        self.word = None

class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        self.root = TrieNode()
        for word in words:
            node = self.root
            for ch in word:
                if ch not in node.children:
                    node.children[ch] = TrieNode()
                node = node.children[ch]
            node.word = word

        self.result = []
        for i in range(len(board)):
            for j in range(len(board[0])):
                self.dfs(board, i, j, self.root)
        return self.result

    def dfs(self, board, i, j, node):
        ch = board[i][j]
        if ch == '#' or ch not in node.children:
            return
        node = node.children[ch]
        if node.word is not None:
            self.result.append(node.word)
            node.word = None

        board[i][j] = '#'
        if i > 0:
            self.dfs(board, i-1, j, node)
        if j > 0:
            self.dfs(board, i, j-1, node)
        if i < len(board)-1:
            self.dfs(board, i+1, j, node)
        if j < len(board[0])-1:
            self.dfs(board, i, j+1, node)
        board[i][j] = ch