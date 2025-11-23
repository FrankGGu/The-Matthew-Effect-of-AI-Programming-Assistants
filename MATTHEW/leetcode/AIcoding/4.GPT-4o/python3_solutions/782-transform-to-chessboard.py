class Solution:
    def movesToChessboard(self, board: List[List[int]]) -> int:
        n = len(board)
        row = [0] * n
        col = [0] * n

        for i in range(n):
            row[i] = board[i][0]
            col[i] = board[0][i]

        if row.count(0) != n // 2 and row.count(1) != n // 2:
            return -1
        if col.count(0) != n // 2 and col.count(1) != n // 2:
            return -1

        row_swaps = sum(row[i] == i % 2 for i in range(n))
        col_swaps = sum(col[i] == i % 2 for i in range(n))

        if n % 2 == 0:
            return (row_swaps + col_swaps) // 2
        else:
            return min(row_swaps, n - row_swaps) + min(col_swaps, n - col_swaps)