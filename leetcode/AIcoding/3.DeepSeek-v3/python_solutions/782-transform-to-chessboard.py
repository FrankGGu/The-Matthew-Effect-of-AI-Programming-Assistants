class Solution:
    def movesToChessboard(self, board: List[List[int]]) -> int:
        n = len(board)
        for i in range(n):
            for j in range(n):
                if board[0][0] ^ board[0][j] ^ board[i][0] ^ board[i][j] != 0:
                    return -1

        row_sum = sum(board[0])
        col_sum = sum(board[i][0] for i in range(n))

        if (row_sum != n // 2 and row_sum != (n + 1) // 2) or (col_sum != n // 2 and col_sum != (n + 1) // 2):
            return -1

        row_swap = 0
        col_swap = 0

        for i in range(n):
            if board[i][0] == i % 2:
                row_swap += 1
            if board[0][i] == i % 2:
                col_swap += 1

        if n % 2 == 1:
            if row_swap % 2 == 1:
                row_swap = n - row_swap
            if col_swap % 2 == 1:
                col_swap = n - col_swap
        else:
            row_swap = min(row_swap, n - row_swap)
            col_swap = min(col_swap, n - col_swap)

        return (row_swap + col_swap) // 2