def checkValid(matrix: List[List[int]]) -> bool:
    n = len(matrix)
    return all(sorted(row) == list(range(1, n + 1)) for row in matrix) and \
           all(sorted(matrix[i][j] for i in range(n)) == list(range(1, n + 1)) for j in range(n))