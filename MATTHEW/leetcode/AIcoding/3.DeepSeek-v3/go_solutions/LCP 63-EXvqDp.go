func findBall(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = dfs(grid, 0, i, m, n)
    }
    return res
}

func dfs(grid [][]int, i, j, m, n int) int {
    if i == m {
        return j
    }
    if grid[i][j] == 1 {
        if j == n-1 || grid[i][j+1] == -1 {
            return -1
        }
        return dfs(grid, i+1, j+1, m, n)
    } else {
        if j == 0 || grid[i][j-1] == 1 {
            return -1
        }
        return dfs(grid, i+1, j-1, m, n)
    }
}