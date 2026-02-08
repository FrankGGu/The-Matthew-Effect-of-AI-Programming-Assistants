class Solution:
    def alphabetBoardPath(self, target: str) -> str:
        board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]
        pos = {}
        for i in range(len(board)):
            for j in range(len(board[i])):
                pos[board[i][j]] = (i, j)

        res = ""
        curr = (0, 0)
        for char in target:
            x, y = pos[char]
            dx = x - curr[0]
            dy = y - curr[1]

            if dx > 0:
                res += 'D' * dx
            if dy > 0:
                res += 'R' * dy
            if dx < 0:
                res += 'U' * abs(dx)
            if dy < 0:
                res += 'L' * abs(dy)
            res += '!'
            curr = (x, y)

        return res