func maxScore(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    dp := make([]int, cols)

    for i := 0; i < rows; i++ {
        newDp := make([]int, cols)
        for j := 0; j < cols; j++ {
            if j > 0 {
                newDp[j] = max(newDp[j-1], dp[j])
            } else {
                newDp[j] = dp[j]
            }
            newDp[j] += grid[i][j]
        }
        dp = newDp
    }

    return dp[cols-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}