class Solution:
    def totalNQueens(self, n: int) -> int:
        def is_safe(row, col, queens):
            for r, c in queens:
                if c == col or abs(row - r) == abs(col - c):
                    return False
            return True

        def solve_n_queens_util(row, queens):
            if row == n:
                return 1
            count = 0
            for col in range(n):
                if is_safe(row, col, queens):
                    count += solve_n_queens_util(row + 1, queens + [(row, col)])
            return count

        return solve_n_queens_util(0, [])