def findDiagonalOrder(matrix):
    if not matrix:
        return []

    rows, cols = len(matrix), len(matrix[0])
    result = []
    for d in range(rows + cols - 1):
        if d % 2 == 0:
            r = min(d, rows - 1)
            c = d - r
            while r >= 0 and c < cols:
                result.append(matrix[r][c])
                r -= 1
                c += 1
        else:
            c = min(d, cols - 1)
            r = d - c
            while c >= 0 and r < rows:
                result.append(matrix[r][c])
                r += 1
                c -= 1
    return result