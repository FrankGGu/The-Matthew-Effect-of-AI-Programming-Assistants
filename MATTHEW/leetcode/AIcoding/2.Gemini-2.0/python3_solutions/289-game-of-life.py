class Solution:
    def gameOfLife(self, board: List[List[int]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        m, n = len(board), len(board[0])

        def count_neighbors(row, col):
            count = 0
            for i in range(max(0, row - 1), min(m, row + 2)):
                for j in range(max(0, col - 1), min(n, col + 2)):
                    if (i, j) != (row, col):
                        if abs(board[i][j]) == 1:
                            count += 1
            return count

        for i in range(m):
            for j in range(n):
                neighbors = count_neighbors(i, j)
                if board[i][j] == 1:
                    if neighbors < 2 or neighbors > 3:
                        board[i][j] = -1
                else:
                    if neighbors == 3:
                        board[i][j] = 2

        for i in range(m):
            for j in range(n):
                if board[i][j] == -1:
                    board[i][j] = 0
                elif board[i][j] == 2:
                    board[i][j] = 1