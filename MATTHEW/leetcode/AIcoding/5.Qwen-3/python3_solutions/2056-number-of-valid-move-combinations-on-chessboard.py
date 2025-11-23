class Solution:
    def countMovesToChessboard(self, chessboard: List[List[int]]) -> int:
        n = len(chessboard)
        row_swaps = 0
        col_swaps = 0
        for i in range(n):
            for j in range(n):
                if chessboard[i][j] != chessboard[i][0] ^ (j & 1):
                    row_swaps += 1
                if chessboard[i][j] != chessboard[0][j] ^ (i & 1):
                    col_swaps += 1
        if n % 2 == 0:
            if row_swaps % 2 != 0 or col_swaps % 2 != 0:
                return -1
            return row_swaps // 2 + col_swaps // 2
        else:
            if row_swaps % 2 != 0 or col_swaps % 2 != 0:
                return -1
            return row_swaps // 2 + col_swaps // 2