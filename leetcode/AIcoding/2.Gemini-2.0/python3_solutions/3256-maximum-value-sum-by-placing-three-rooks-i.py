class Solution:
    def solve(self, board: list[list[int]]) -> int:
        m = len(board)
        n = len(board[0])
        ans = float('-inf')
        for r1 in range(m):
            for c1 in range(n):
                for r2 in range(m):
                    for c2 in range(n):
                        if (r1 == r2 and c1 == c2):
                            continue
                        for r3 in range(m):
                            for c3 in range(n):
                                if (r3 == r1 and c3 == c1) or (r3 == r2 and c3 == c2):
                                    continue
                                temp_board = [row[:] for row in board]
                                sum_val = 0
                                sum_val += temp_board[r1][c1]
                                temp_board[r1][c1] = 0
                                sum_val += temp_board[r2][c2]
                                temp_board[r2][c2] = 0
                                sum_val += temp_board[r3][c3]
                                temp_board[r3][c3] = 0
                                ans = max(ans, sum_val)
        return ans