class Solution:
    def exist(self, board: list[list[str]], word: str) -> bool:
        m, n = len(board), len(board[0])
        len_word = len(word)

        def dfs(r, c, k):
            if k == len_word:
                return True

            if not (0 <= r < m and 0 <= c < n) or board[r][c] != word[k]:
                return False

            temp = board[r][c]
            board[r][c] = '#'  # Mark as visited

            # Explore neighbors
            found = (dfs(r + 1, c, k + 1) or
                     dfs(r - 1, c, k + 1) or
                     dfs(r, c + 1, k + 1) or
                     dfs(r, c - 1, k + 1))

            board[r][c] = temp  # Backtrack: restore cell

            return found

        for r_start in range(m):
            for c_start in range(n):
                if dfs(r_start, c_start, 0):
                    return True
        return False