func numEnclaves(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    var dfs func(int, int)
    dfs = func(r, c int) {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
            return
        }
        grid[r][c] = 0
        for _, dir := range directions {
            dfs(r+dir[0], c+dir[1])
        }
    }

    for r := 0; r < rows; r++ {
        if grid[r][0] == 1 {
            dfs(r, 0)
        }
        if grid[r][cols-1] == 1 {
            dfs(r, cols-1)
        }
    }

    for c := 0; c < cols; c++ {
        if grid[0][c] == 1 {
            dfs(0, c)
        }
        if grid[rows-1][c] == 1 {
            dfs(rows-1, c)
        }
    }

    count := 0
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                count++
            }
        }
    }

    return count
}