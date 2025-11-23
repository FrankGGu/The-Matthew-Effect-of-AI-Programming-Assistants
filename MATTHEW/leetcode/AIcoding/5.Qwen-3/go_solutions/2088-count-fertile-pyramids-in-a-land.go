package main

func countPyramids(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := m - 1; i >= 0; i-- {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                if i == m-1 || j == 0 || j == n-1 {
                    dp[i][j] = 1
                } else {
                    dp[i][j] = min(dp[i+1][j-1], dp[i+1][j], dp[i+1][j+1]) + 1
                }
            } else {
                dp[i][j] = 0
            }
        }
    }

    res := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            res += max(0, dp[i][j]-1)
        }
    }

    return res
}

func min(a, b, c int) int {
    if a <= b && a <= c {
        return a
    }
    if b <= c {
        return b
    }
    return c
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}