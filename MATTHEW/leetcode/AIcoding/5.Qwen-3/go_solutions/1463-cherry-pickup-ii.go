package main

func cherryPickup(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := m - 1; i >= 0; i-- {
        for j1 := 0; j1 < n; j1++ {
            for j2 := 0; j2 < n; j2++ {
                if i == m-1 {
                    dp[i][j1] = max(dp[i][j1], grid[i][j1]+grid[i][j2])
                } else {
                    for dj1 := -1; dj1 <= 1; dj1++ {
                        for dj2 := -1; dj2 <= 1; dj2++ {
                            nj1, nj2 := j1+dj1, j2+dj2
                            if nj1 >= 0 && nj1 < n && nj2 >= 0 && nj2 < n {
                                dp[i][j1] = max(dp[i][j1], grid[i][j1]+grid[i][j2]+dp[i+1][nj1])
                            }
                        }
                    }
                }
            }
        }
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}