class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        trie = {}
        for word in words:
            node = trie
            for char in word:
                if char not in node:
                    node[char] = {}
                node = node[char]
            node['#'] = True

        result = []
        rows, cols = len(board), len(board[0])

        def dfs(r, c, node, path):
            char = board[r][c]
            if char not in node:
                return
            node = node[char]
            path += char
            if '#' in node:
                result.append(path)
                del node['#']
            board[r][c] = '*'
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols:
                    dfs(nr, nc, node, path)
            board[r][c] = char

        for r in range(rows):
            for c in range(cols):
                dfs(r, c, trie, "")

        return result