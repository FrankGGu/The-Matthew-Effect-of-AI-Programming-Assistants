from typing import List

class TrieNode:
    def __init__(self):
        self.children = {}
        self.word = None

class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        root = TrieNode()
        for word in words:
            node = root
            for char in word:
                if char not in node.children:
                    node.children[char] = TrieNode()
                node = node.children[char]
            node.word = word

        m, n = len(board), len(board[0])
        found_words = []

        def dfs(r, c, node_in_trie):
            if not (0 <= r < m and 0 <= c < n):
                return

            char = board[r][c]
            if char == '#':
                return

            if char not in node_in_trie.children:
                return

            next_trie_node = node_in_trie.children[char]

            if next_trie_node.word:
                found_words.append(next_trie_node.word)
                next_trie_node.word = None

            original_char = board[r][c]
            board[r][c] = '#'

            dfs(r + 1, c, next_trie_node)
            dfs(r - 1, c, next_trie_node)
            dfs(r, c + 1, next_trie_node)
            dfs(r, c - 1, next_trie_node)

            board[r][c] = original_char

            if not next_trie_node.children and not next_trie_node.word:
                del node_in_trie.children[char]

        for r in range(m):
            for c in range(n):
                dfs(r, c, root)

        return found_words