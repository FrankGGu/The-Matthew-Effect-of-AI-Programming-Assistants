class Solution:
    def alphabetBoardPath(self, target: str) -> str:
        board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]
        pos = {}
        for i in range(len(board)):
            for j in range(len(board[i])):
                pos[board[i][j]] = (i, j)

        res = []
        current = (0, 0)
        for c in target:
            target_pos = pos[c]
            dx = target_pos[0] - current[0]
            dy = target_pos[1] - current[1]

            if c == 'z':
                path = 'L' * (-dy) if dy < 0 else 'R' * dy
                path += 'D' * dx
            else:
                path = 'U' * (-dx) if dx < 0 else 'D' * dx
                path += 'L' * (-dy) if dy < 0 else 'R' * dy
            res.append(path + '!')
            current = target_pos
        return ''.join(res)