def minimum_passes(grid: list[list[int]]) -> int:
    n = len(grid)
    m = len(grid[0])
    q = []
    negative_count = 0
    for i in range(n):
        for j in range(m):
            if grid[i][j] < 0:
                negative_count += 1
            elif grid[i][j] > 0:
                q.append((i, j))

    passes = 0
    while q:
        size = len(q)
        for _ in range(size):
            i, j = q.pop(0)

            neighbors = [(i+1, j), (i-1, j), (i, j+1), (i, j-1)]
            for r, c in neighbors:
                if 0 <= r < n and 0 <= c < m and grid[r][c] < 0:
                    grid[r][c] *= -1
                    negative_count -= 1
                    q.append((r, c))

        passes += 1

    if negative_count == 0:
        return passes - 1
    else:
        return -1