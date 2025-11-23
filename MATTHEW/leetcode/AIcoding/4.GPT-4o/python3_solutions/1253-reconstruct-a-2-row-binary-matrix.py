def reconstructMatrix(upper: int, lower: int, colsum: List[int]) -> List[List[int]]:
    n = len(colsum)
    result = [[0] * n for _ in range(2)]

    for i in range(n):
        if colsum[i] == 2:
            result[0][i] = result[1][i] = 1
            upper -= 1
            lower -= 1
        elif colsum[i] == 1:
            if upper > lower:
                result[0][i] = 1
                upper -= 1
            else:
                result[1][i] = 1
                lower -= 1

    if upper == 0 and lower == 0:
        return result
    return []