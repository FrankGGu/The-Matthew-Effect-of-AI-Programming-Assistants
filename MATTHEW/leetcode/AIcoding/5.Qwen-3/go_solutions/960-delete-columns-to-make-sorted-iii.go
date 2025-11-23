package main

func minDeletionSizeGrid(grid []string) int {
    m := len(grid)
    n := len(grid[0])
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            valid := true
            for k := 0; k < m; k++ {
                if grid[k][j] > grid[k][i] {
                    valid = false
                    break
                }
            }
            if valid {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    maxLen := 0
    for i := 0; i < n; i++ {
        maxLen = max(maxLen, dp[i])
    }
    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}