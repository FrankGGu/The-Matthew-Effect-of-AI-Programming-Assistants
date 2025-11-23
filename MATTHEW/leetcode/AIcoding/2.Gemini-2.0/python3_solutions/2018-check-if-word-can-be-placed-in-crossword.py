class Solution:
    def placeWordInCrossword(self, board: List[List[str]], word: str) -> bool:
        m, n = len(board), len(board[0])
        word_len = len(word)

        def check(row, col, row_dir, col_dir):
            for i in range(word_len):
                r, c = row + i * row_dir, col + i * col_dir
                if not (0 <= r < m and 0 <= c < n):
                    return False
                if board[r][c] != ' ' and board[r][c] != word[i]:
                    return False

            if row - row_dir >= 0 and row - row_dir < m and col - col_dir >= 0 and col - col_dir < n and board[row - row_dir][col - col_dir] != '#':
                return False
            if row + word_len * row_dir >= 0 and row + word_len * row_dir < m and col + word_len * col_dir >= 0 and col + word_len * col_dir < n and board[row + word_len * row_dir][col + word_len * col_dir] != '#':
                return False
            return True

        for i in range(m):
            for j in range(n):
                if board[i][j] == '#':
                    continue

                if board[i][j] == ' ' or board[i][j] == word[0]:
                    if j + word_len <= n:
                        valid = True
                        if j > 0 and board[i][j-1] != '#':
                            valid = False

                        if valid and check(i, j, 0, 1):

                            if j + word_len == n or board[i][j + word_len] == '#':
                                return True
                    if j - word_len + 1 >= 0:
                         valid = True
                         if j < n-1 and board[i][j+1] != '#':
                            valid = False

                         if valid and check(i, j, 0, -1):
                            w = word[::-1]
                            if j - word_len == -1 or board[i][j - word_len] == '#':
                                return True

                if board[i][j] == ' ' or board[i][j] == word[0]:
                    if i + word_len <= m:
                         valid = True
                         if i > 0 and board[i-1][j] != '#':
                            valid = False

                         if valid and check(i, j, 1, 0):
                            if i + word_len == m or board[i + word_len][j] == '#':
                                return True
                    if i - word_len + 1 >= 0:
                         valid = True
                         if i < m-1 and board[i+1][j] != '#':
                            valid = False
                         if valid and check(i, j, -1, 0):
                            w = word[::-1]
                            if i - word_len == -1 or board[i - word_len][j] == '#':
                                return True
        return False