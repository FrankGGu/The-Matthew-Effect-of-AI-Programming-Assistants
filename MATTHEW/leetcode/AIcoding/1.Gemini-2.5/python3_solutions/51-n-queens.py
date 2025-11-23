class Solution:
    def solveNQueens(self, n: int) -> list[list[str]]:
        results = []
        board = [['.' for _ in range(n)] for _ in range(n)]

        cols = set()
        diag1 = set()  # r - c
        diag2 = set()  # r + c

        def backtrack(row):
            if row == n:
                current_solution = ["".join(board[i]) for i in range(n)]
                results.append(current_solution)
                return

            for col in range(n):
                if col in cols or (row - col) in diag1 or (row + col) in diag2:
                    continue

                cols.add(col)
                diag1.add(row - col)
                diag2.add(row + col)
                board[row][col] = 'Q'

                backtrack(row + 1)

                board[row][col] = '.'
                cols.remove(col)
                diag1.remove(row - col)
                diag2.remove(row + col)

        backtrack(0)
        return results