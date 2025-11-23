class Solution:
    def movesToChessboard(self, board: List[List[int]]) -> int:
        n = len(board)
        row_masks = [0] * n
        for i in range(n):
            for j in range(n):
                row_masks[i] |= board[i][j] << j

        row_count = {}
        for mask in row_masks:
            row_count[mask] = row_count.get(mask, 0) + 1

        if len(row_count) > 2:
            return -1

        row_values = list(row_count.keys())
        if len(row_values) == 2:
            if row_values[0] ^ row_values[1] != (1 << n) - 1:
                return -1
            if row_count[row_values[0]] < n // 2 or row_count[row_values[0]] > (n + 1) // 2:
                return -1
        else:
            if row_count[row_values[0]] != n:
                return -1

        col_masks = [0] * n
        for j in range(n):
            for i in range(n):
                col_masks[j] |= board[i][j] << i

        col_count = {}
        for mask in col_masks:
            col_count[mask] = col_count.get(mask, 0) + 1

        if len(col_count) > 2:
            return -1

        col_values = list(col_count.keys())
        if len(col_values) == 2:
            if col_values[0] ^ col_values[1] != (1 << n) - 1:
                return -1
            if col_count[col_values[0]] < n // 2 or col_count[col_values[0]] > (n + 1) // 2:
                return -1
        else:
            if col_count[col_values[0]] != n:
                return -1

        row_moves = 0
        for i in range(n):
            if (row_masks[0] >> i) & 1 != i % 2:
                row_moves += 1

        col_moves = 0
        for j in range(n):
            if (col_masks[0] >> j) & 1 != j % 2:
                col_moves += 1

        row_moves = min(row_moves, n - row_moves)
        col_moves = min(col_moves, n - col_moves)

        if n % 2 == 1:
            return row_moves // 2 + col_moves // 2
        else:
            return row_moves // 2 + col_moves // 2