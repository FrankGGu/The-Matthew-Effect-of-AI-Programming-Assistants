func getMaximumGold(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    maxGold := 0

    var dfs func(x, y, currentGold int)
    dfs = func(x, y, currentGold int) {
        currentGold += grid[x][y]
        maxGold = max(maxGold, currentGold)
        temp := grid[x][y]
        grid[x][y] = 0

        directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
        for _, dir := range directions {
            newX, newY := x+dir[0], y+dir[1]
            if newX >= 0 && newX < rows && newY >= 0 && newY < cols && grid[newX][newY] > 0 {
                dfs(newX, newY, currentGold)
            }
        }

        grid[x][y] = temp
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] > 0 {
                dfs(i, j, 0)
            }
        }
    }

    return maxGold
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}