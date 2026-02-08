def matrixReshape(mat, r, c):
    if len(mat) * len(mat[0]) != r * c:
        return mat
    return [[mat[i // len(mat[0])][i % len(mat[0])] for i in range(r * c)]]