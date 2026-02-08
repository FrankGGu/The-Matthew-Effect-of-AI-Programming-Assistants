class Solution:
    def numRookCaptures(self, board: List[List[str]]) -> int:
        # Find the position of the rook
        for i in range(8):
            for j in range(8):
                if board[i][j] == 'R':
                    x, y = i, j
                    break

        count = 0
        # Check north
        i = x - 1
        while i >= 0:
            if board[i][y] == 'p':
                count += 1
                break
            if board[i][y] != '.':
                break
            i -= 1

        # Check south
        i = x + 1
        while i < 8:
            if board[i][y] == 'p':
                count += 1
                break
            if board[i][y] != '.':
                break
            i += 1

        # Check west
        j = y - 1
        while j >= 0:
            if board[x][j] == 'p':
                count += 1
                break
            if board[x][j] != '.':
                break
            j -= 1

        # Check east
        j = y + 1
        while j < 8:
            if board[x][j] == 'p':
                count += 1
                break
            if board[x][j] != '.':
                break
            j += 1

        return count