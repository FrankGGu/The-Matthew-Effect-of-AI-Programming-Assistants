def construct2DArray(original, m, n):
    if m * n != len(original):
        return []
    return [original[i * n:(i + 1) * n] for i in range(m)]