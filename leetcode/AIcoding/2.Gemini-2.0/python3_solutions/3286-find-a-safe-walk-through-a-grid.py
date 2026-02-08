def findSafeWalk(grid: list[list[int]]) -> list[list[int]]:
    m, n = len(grid), len(grid[0])
    safe_grid = [[1] * n for _ in range(m)]

    for i in range(m):
        for j in range(n):
            if grid[i][j] == 0:
                safe_grid[i][j] = 0
                for x in range(max(0, i - 1), min(m, i + 2)):
                    for y in range(max(0, j - 1), min(n, j + 2)):
                        safe_grid[x][y] = 0

    q = [(0, 0, [(0, 0)])]
    visited = set()

    while q:
        x, y, path = q.pop(0)

        if (x, y) == (m - 1, n - 1):
            return path

        visited.add((x, y))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        for dx, dy in directions:
            nx, ny = x + dx, y + dy
            if 0 <= nx < m and 0 <= ny < n and safe_grid[nx][ny] == 1 and (nx, ny) not in visited:
                q.append((nx, ny, path + [(nx, ny)]))

    return []