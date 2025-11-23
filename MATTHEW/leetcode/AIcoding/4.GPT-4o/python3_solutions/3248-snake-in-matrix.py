def snakePattern(matrix):
    if not matrix or not matrix[0]:
        return []

    result = []
    rows, cols = len(matrix), len(matrix[0])
    for i in range(rows):
        if i % 2 == 0:
            result.extend(matrix[i])
        else:
            result.extend(matrix[i][::-1])

    return result