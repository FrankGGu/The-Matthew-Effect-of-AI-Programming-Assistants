def solve():
    n, m, k = map(int, input().split())
    grid = []
    for _ in range(n):
        grid.append(list(map(int, input().split())))

    q = [(0, 0, 0)]
    visited = set()
    visited.add((0, 0))

    while q:
        r, c, steps = q.pop(0)

        if r == n - 1 and c == m - 1:
            print(steps)
            return

        # Move right
        if c + 1 < m and (r, c + 1) not in visited:
            q.append((r, c + 1, steps + 1))
            visited.add((r, c + 1))

        # Move down
        if r + 1 < n and (r + 1, c) not in visited:
            q.append((r + 1, c, steps + 1))
            visited.add((r + 1, c))

        # Teleport
        if grid[r][c] == 1:
            for i in range(n):
                for j in range(m):
                    if grid[i][j] == 1 and (i, j) != (r, c) and (i, j) not in visited:
                        q.append((i, j, steps + 1))
                        visited.add((i, j))

    print(-1)

solve()