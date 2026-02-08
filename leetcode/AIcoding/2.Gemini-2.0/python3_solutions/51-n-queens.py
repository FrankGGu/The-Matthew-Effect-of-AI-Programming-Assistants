class Solution:
    def solveNQueens(self, n: int) -> list[list[str]]:
        def is_safe(board, row, col):
            for i in range(row):
                if board[i] == col or abs(board[i] - col) == row - i:
                    return False
            return True

        def solve_n_queens_util(board, row, solutions):
            if row == n:
                solution = []
                for i in range(n):
                    row_str = '.' * board[i] + 'Q' + '.' * (n - board[i] - 1)
                    solution.append(row_str)
                solutions.append(solution)
                return

            for col in range(n):
                if is_safe(board, row, col):
                    board[row] = col
                    solve_n_queens_util(board, row + 1, solutions)

        solutions = []
        board = [0] * n
        solve_n_queens_util(board, 0, solutions)
        return solutions