def spiralMatrixIII(R: int, C: int, r0: int, c0: int):
    result = []
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    steps = 0
    while len(result) < R * C:
        for i in range(4):
            for _ in range(steps // 2 + 1):
                if 0 <= r0 < R and 0 <= c0 < C:
                    result.append([r0, c0])
                r0 += directions[i][0]
                c0 += directions[i][1]
            if i % 2 == 1:
                steps += 1
    return result