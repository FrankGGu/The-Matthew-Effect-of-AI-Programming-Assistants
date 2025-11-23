func uniquePathsIII(grid [][]int) int {
    startX, startY, endX, endY, emptyCount := 0, 0, 0, 0, 0
    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] == 1 {
                startX, startY = i, j
            } else if grid[i][j] == 2 {
                endX, endY = i, j
            }
            if grid[i][j] != -1 {
                emptyCount++
            }
        }
    }

    var dfs func(x, y, count int) int
    dfs = func(x, y, count int) int {
        if x < 0 || x >= len(grid) || y < 0 || y >= len(grid[0]) || grid[x][y] == -1 {
            return 0
        }
        if x == endX && y == endY {
            if count == emptyCount {
                return 1
            }
            return 0
        }

        temp := grid[x][y]
        grid[x][y] = -1
        paths := dfs(x+1, y, count+1) + dfs(x-1, y, count+1) + dfs(x, y+1, count+1) + dfs(x, y-1, count+1)
        grid[x][y] = temp

        return paths
    }

    return dfs(startX, startY, 1)
}