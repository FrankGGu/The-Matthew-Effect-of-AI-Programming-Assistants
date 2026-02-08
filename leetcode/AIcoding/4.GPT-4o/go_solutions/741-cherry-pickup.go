func cherryPickup(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, m)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }
    dp[0][0][0] = grid[0][0]

    for r1 := 0; r1 < n; r1++ {
        for r2 := 0; r2 < n; r2++ {
            for c := 0; c < m; c++ {
                if dp[r1][r2][c] == -1 {
                    continue
                }
                if r1 < n-1 {
                    dp[r1+1][r2][c] = max(dp[r1+1][r2][c], dp[r1][r2][c]+getCherries(grid, r1+1, c))
                }
                if r2 < n-1 {
                    dp[r1][r2+1][c] = max(dp[r1][r2+1][c], dp[r1][r2][c]+getCherries(grid, r2+1, c))
                }
                if c < m-1 {
                    dp[r1][r2][c+1] = max(dp[r1][r2][c+1], dp[r1][r2][c]+getCherries(grid, r1, c+1)+getCherries(grid, r2, c+1))
                }
            }
        }
    }

    maxCherries := 0
    for c := 0; c < m; c++ {
        for r1 := 0; r1 < n; r1++ {
            for r2 := r1; r2 < n; r2++ {
                if dp[r1][r2][c] != -1 {
                    maxCherries = max(maxCherries, dp[r1][r2][c])
                }
            }
        }
    }

    return maxCherries
}

func getCherries(grid [][]int, r, c int) int {
    if r < 0 || r >= len(grid) || c < 0 || c >= len(grid[0]) {
        return 0
    }
    return grid[r][c]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}