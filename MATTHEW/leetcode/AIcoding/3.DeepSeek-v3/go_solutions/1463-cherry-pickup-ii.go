func cherryPickup(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }

    var dfs func(row, col1, col2 int) int
    dfs = func(row, col1, col2 int) int {
        if row == m {
            return 0
        }
        if dp[row][col1][col2] != -1 {
            return dp[row][col1][col2]
        }

        res := 0
        for i := -1; i <= 1; i++ {
            newCol1 := col1 + i
            if newCol1 < 0 || newCol1 >= n {
                continue
            }
            for j := -1; j <= 1; j++ {
                newCol2 := col2 + j
                if newCol2 < 0 || newCol2 >= n {
                    continue
                }
                res = max(res, dfs(row+1, newCol1, newCol2))
            }
        }

        cherries := grid[row][col1]
        if col1 != col2 {
            cherries += grid[row][col2]
        }
        dp[row][col1][col2] = res + cherries
        return dp[row][col1][col2]
    }

    return dfs(0, 0, n-1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}