class MagicBoard:
    def canPlace(self, board: List[List[int]], row: int, col: int) -> bool:
        for i in range(len(board)):
            for j in range(len(board)):
                if board[i][j] == 1 and (abs(i - row) == abs(j - col) or i == row or j == col):
                    return False
        return True

    def backtrack(self, board: List[List[int]], row: int, count: int) -> int:
        if count == 0:
            return 1
        if row >= len(board):
            return 0

        total = 0
        for col in range(len(board)):
            if self.canPlace(board, row, col):
                board[row][col] = 1
                total += self.backtrack(board, row + 1, count - 1)
                board[row][col] = 0

        total += self.backtrack(board, row + 1, count)
        return total

    def magicBoard(self, n: int, k: int) -> int:
        board = [[0] * n for _ in range(n)]
        return self.backtrack(board, 0, k)