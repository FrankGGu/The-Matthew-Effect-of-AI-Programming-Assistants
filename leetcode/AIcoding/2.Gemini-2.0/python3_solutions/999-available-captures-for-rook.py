class Solution:
    def numRookCaptures(self, board: List[List[str]]) -> int:
        rook_row, rook_col = -1, -1
        for i in range(8):
            for j in range(8):
                if board[i][j] == 'R':
                    rook_row, rook_col = i, j
                    break
            if rook_row != -1:
                break

        count = 0
        # Check up
        for i in range(rook_row - 1, -1, -1):
            if board[i][rook_col] == 'p':
                count += 1
                break
            elif board[i][rook_col] == 'B':
                break

        # Check down
        for i in range(rook_row + 1, 8):
            if board[i][rook_col] == 'p':
                count += 1
                break
            elif board[i][rook_col] == 'B':
                break

        # Check left
        for j in range(rook_col - 1, -1, -1):
            if board[rook_row][j] == 'p':
                count += 1
                break
            elif board[rook_row][j] == 'B':
                break

        # Check right
        for j in range(rook_col + 1, 8):
            if board[rook_row][j] == 'p':
                count += 1
                break
            elif board[rook_row][j] == 'B':
                break

        return count