def solveNQueens(n: int):
    def backtrack(row, cols, diag1, diag2):
        if row == n:
            result.append([''.join(board[i]) for i in range(n)])
            return
        for col in range(n):
            if col in cols or (row - col) in diag1 or (row + col) in diag2:
                continue
            board[row][col] = 'Q'
            cols.add(col)
            diag1.add(row - col)
            diag2.add(row + col)
            backtrack(row + 1, cols, diag1, diag2)
            board[row][col] = '.'
            cols.remove(col)
            diag1.remove(row - col)
            diag2.remove(row + col)

    result = []
    board = [['.'] * n for _ in range(n)]
    backtrack(0, set(), set(), set())
    return result