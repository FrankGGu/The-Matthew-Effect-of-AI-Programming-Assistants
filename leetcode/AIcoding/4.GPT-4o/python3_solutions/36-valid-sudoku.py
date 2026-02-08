def isValidSudoku(board):
    rows, cols, boxes = set(), set(), set()

    for r in range(9):
        for c in range(9):
            if board[r][c] != '.':
                num = board[r][c]
                if (r, num) in rows or (c, num) in cols or (r // 3, c // 3, num) in boxes:
                    return False
                rows.add((r, num))
                cols.add((c, num))
                boxes.add((r // 3, c // 3, num))

    return True