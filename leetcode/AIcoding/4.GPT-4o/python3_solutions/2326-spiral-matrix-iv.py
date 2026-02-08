def spiralMatrix(m: int, n: int, head: List[int]) -> List[List[int]]:
    matrix = [[-1] * n for _ in range(m)]
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    x, y = 0, 0
    dir_idx = 0

    for num in head:
        matrix[x][y] = num
        next_x, next_y = x + directions[dir_idx][0], y + directions[dir_idx][1]

        if 0 <= next_x < m and 0 <= next_y < n and matrix[next_x][next_y] == -1:
            x, y = next_x, next_y
        else:
            dir_idx = (dir_idx + 1) % 4
            x += directions[dir_idx][0]
            y += directions[dir_idx][1]

    return matrix