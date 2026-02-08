func canPartition(grid [][]int) bool {
    totalSum := 0
    for _, row := range grid {
        for _, num := range row {
            totalSum += num
        }
    }

    if totalSum%4 != 0 {
        return false
    }

    target := totalSum / 4
    n := len(grid)
    m := len(grid[0])
    dp := make([]bool, target+1)
    dp[0] = true

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            for k := target; k >= grid[i][j]; k-- {
                dp[k] = dp[k] || dp[k-grid[i][j]]
            }
        }
    }

    return dp[target]
}