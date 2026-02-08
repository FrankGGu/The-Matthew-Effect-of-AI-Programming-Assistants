class Solution:
    def placeWordInCrossword(self, board: List[List[str]], word: str) -> bool:
        m, n = len(board), len(board[0])
        length = len(word)

        def canPlace(pos, dr, dc):
            r, c = pos
            if dr == 1:
                if r > 0 and board[r-1][c] != '#':
                    return False
                if r + length < m and board[r + length][c] != '#':
                    return False
            else:
                if c > 0 and board[r][c-1] != '#':
                    return False
                if c + length < n and board[r][c + length] != '#':
                    return False

            for i in range(length):
                nr, nc = r + i * dr, c + i * dc
                if nr >= m or nc >= n:
                    return False
                cell = board[nr][nc]
                if cell != ' ' and cell != word[i] and cell != word[length - 1 - i]:
                    return False
            return True

        for i in range(m):
            for j in range(n):
                if board[i][j] == '#':
                    continue
                if (j == 0 or board[i][j-1] == '#') and j + length <= n:
                    if canPlace((i, j), 0, 1):
                        return True
                if (i == 0 or board[i-1][j] == '#') and i + length <= m:
                    if canPlace((i, j), 1, 0):
                        return True
        return False