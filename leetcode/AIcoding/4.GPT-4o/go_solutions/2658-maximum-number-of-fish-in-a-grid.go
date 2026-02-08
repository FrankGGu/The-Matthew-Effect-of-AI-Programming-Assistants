func findMaxFish(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    maxFish := 0

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
            return 0
        }
        fish := grid[r][c]
        grid[r][c] = 0
        fish += dfs(r+1, c) + dfs(r-1, c) + dfs(r, c+1) + dfs(r, c-1)
        return fish
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] > 0 {
                maxFish = max(maxFish, dfs(r, c))
            }
        }
    }

    return maxFish
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}