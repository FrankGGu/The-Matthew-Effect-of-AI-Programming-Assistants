class Solution:
    def exist(self, board: list[list[str]], word: str) -> bool:
        rows = len(board)
        cols = len(board[0])

        def dfs(r, c, k):
            if k == len(word):
                return True

            if not (0 <= r < rows and 0 <= c < cols) or board[r][c] != word[k]:
                return False

            temp = board[r][c]
            board[r][c] = '#'

            found = (dfs(r + 1, c, k + 1) or
                     dfs(r - 1, c, k + 1) or
                     dfs(r, c + 1, k + 1) or
                     dfs(r, c - 1, k + 1))

            board[r][c] = temp

            return found

        for r in range(rows):
            for c in range(cols):
                if board[r][c] == word[0]:
                    if dfs(r, c, 0):
                        return True

        return False