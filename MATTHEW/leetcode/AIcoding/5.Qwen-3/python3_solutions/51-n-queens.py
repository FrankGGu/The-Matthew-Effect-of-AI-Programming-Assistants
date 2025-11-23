class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        def backtrack(row, cols, diag1, diag2, path):
            if row == n:
                result.append(path[:])
                return
            for col in range(n):
                if col not in cols and (row + col) not in diag1 and (row - col) not in diag2:
                    cols.add(col)
                    diag1.add(row + col)
                    diag2.add(row - col)
                    path.append('.' * col + 'Q' + '.' * (n - col - 1))
                    backtrack(row + 1, cols, diag1, diag2, path)
                    path.pop()
                    cols.remove(col)
                    diag1.remove(row + col)
                    diag2.remove(row - col)

        result = []
        backtrack(0, set(), set(), set(), [])
        return result