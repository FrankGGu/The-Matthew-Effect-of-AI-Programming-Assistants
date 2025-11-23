func getMaximumGold(grid [][]int) int {
    maxGold := 0
    m, n := len(grid), len(grid[0])

    var dfs func(int, int, int) int
    dfs = func(i, j, currentGold int) int {
        if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 {
            return currentGold
        }
        gold := grid[i][j]
        grid[i][j] = 0
        maxPath := 0
        directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
        for _, dir := range directions {
            ni, nj := i + dir[0], j + dir[1]
            maxPath = max(maxPath, dfs(ni, nj, currentGold + gold))
        }
        grid[i][j] = gold
        return maxPath
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] != 0 {
                maxGold = max(maxGold, dfs(i, j, 0))
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