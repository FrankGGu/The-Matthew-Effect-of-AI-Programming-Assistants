func findMaxFish(grid [][]int) int {
    maxFish := 0
    m, n := len(grid), len(grid[0])
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 {
            return 0
        }
        fish := grid[i][j]
        grid[i][j] = 0
        for _, dir := range directions {
            fish += dfs(i + dir[0], j + dir[1])
        }
        return fish
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] > 0 {
                currentFish := dfs(i, j)
                if currentFish > maxFish {
                    maxFish = currentFish
                }
            }
        }
    }

    return maxFish
}