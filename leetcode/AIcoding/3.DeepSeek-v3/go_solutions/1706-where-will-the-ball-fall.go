func findBall(grid [][]int) []int {
    m, n := len(grid), len(grid[0])
    res := make([]int, n)

    for i := 0; i < n; i++ {
        res[i] = dfs(grid, 0, i, m, n)
    }

    return res
}

func dfs(grid [][]int, row, col, m, n int) int {
    if row == m {
        return col
    }

    nextCol := col + grid[row][col]

    if nextCol < 0 || nextCol >= n || grid[row][col] != grid[row][nextCol] {
        return -1
    }

    return dfs(grid, row+1, nextCol, m, n)
}