func strongestForceField(grid [][]int) int {
    n, m := len(grid), len(grid[0])
    dp := make([]int, m)
    for j := 0; j < m; j++ {
        dp[j] = grid[0][j]
    }
    for i := 1; i < n; i++ {
        newDp := make([]int, m)
        for j := 0; j < m; j++ {
            newDp[j] = grid[i][j] + dp[j]
            if j > 0 {
                newDp[j] = max(newDp[j], grid[i][j]+dp[j-1])
            }
            if j < m-1 {
                newDp[j] = max(newDp[j], grid[i][j]+dp[j+1])
            }
        }
        dp = newDp
    }
    maxForce := 0
    for j := 0; j < m; j++ {
        maxForce = max(maxForce, dp[j])
    }
    return maxForce
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}