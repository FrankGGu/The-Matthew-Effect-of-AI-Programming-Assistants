class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        def backtrack(row, cols, diag1, diag2, path):
            if row == n:
                res.append(path)
                return
            for col in range(n):
                if col not in cols and (row - col) not in diag1 and (row + col) not in diag2:
                    backtrack(row + 1, cols | {col}, diag1 | {row - col}, diag2 | {row + col}, path + [col])

        res = []
        backtrack(0, set(), set(), set(), [])
        return [['.' * col + 'Q' + '.' * (n - col - 1) for col in sol] for sol in res]