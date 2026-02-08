class Solution:
    def totalNQueens(self, n: int) -> int:
        def backtrack(row, diagonals, anti_diagonals, cols):
            if row == n:
                return 1
            solutions = 0
            for col in range(n):
                diagonal = row - col
                anti_diagonal = row + col
                if (col in cols or 
                    diagonal in diagonals or 
                    anti_diagonal in anti_diagonals):
                    continue
                cols.add(col)
                diagonals.add(diagonal)
                anti_diagonals.add(anti_diagonal)
                solutions += backtrack(row + 1, diagonals, anti_diagonals, cols)
                cols.remove(col)
                diagonals.remove(diagonal)
                anti_diagonals.remove(anti_diagonal)
            return solutions

        return backtrack(0, set(), set(), set())