func cherryPickup(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    dp := make([][][]int, rows)
    for i := range dp {
        dp[i] = make([][]int, cols)
        for j := range dp[i] {
            dp[i][j] = make([]int, cols)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }

    var dfs func(r1, c1, r2, c2 int) int
    dfs = func(r1, c1, r2, c2 int) int {
        if r1 < 0 || r1 >= rows || c1 < 0 || c1 >= cols || r2 < 0 || r2 >= rows || c2 < 0 || c2 >= cols {
            return 0
        }
        if grid[r1][c1] == -1 || grid[r2][c2] == -1 {
            return 0
        }
        if dp[r1][c1][c2] != -1 {
            return dp[r1][c1][c2]
        }
        if r1 == rows-1 && c1 == cols-1 {
            return grid[r1][c1]
        }
        if r2 == rows-1 && c2 == cols-1 {
            return grid[r2][c2]
        }

        cherries := grid[r1][c1]
        if r1 != r2 || c1 != c2 {
            cherries += grid[r2][c2]
        }

        maxCherries := 0
        for dr1 := -1; dr1 <= 1; dr1++ {
            for dc1 := -1; dc1 <= 1; dc1++ {
                for dr2 := -1; dr2 <= 1; dr2++ {
                    for dc2 := -1; dc2 <= 1; dc2++ {
                        maxCherries = max(maxCherries, dfs(r1+dr1, c1+dc1, r2+dr2, c2+dc2))
                    }
                }
            }
        }
        dp[r1][c1][c2] = cherries + maxCherries
        return dp[r1][c1][c2]
    }

    return dfs(0, 0, 0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}