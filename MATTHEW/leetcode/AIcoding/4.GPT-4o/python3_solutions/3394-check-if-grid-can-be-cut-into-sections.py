def canCutIntoSections(grid):
    m, n = len(grid), len(grid[0])
    total_count = sum(row.count('1') for row in grid)

    if total_count == 0:
        return True

    def dfs(x, y):
        if 0 <= x < m and 0 <= y < n and grid[x][y] == '1':
            grid[x][y] = '0'
            dfs(x + 1, y)
            dfs(x - 1, y)
            dfs(x, y + 1)
            dfs(x, y - 1)

    sections = 0
    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                sections += 1
                dfs(i, j)

    return sections == total_count