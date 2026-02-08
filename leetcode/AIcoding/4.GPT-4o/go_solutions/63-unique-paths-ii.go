func uniquePathsWithObstacles(obstacleGrid [][]int) int {
    if len(obstacleGrid) == 0 || obstacleGrid[0][0] == 1 {
        return 0
    }

    m := len(obstacleGrid)
    n := len(obstacleGrid[0])
    dp := make([]int, n)
    dp[0] = 1

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if obstacleGrid[i][j] == 1 {
                dp[j] = 0
            } else if j > 0 {
                dp[j] += dp[j-1]
            }
        }
    }
    return dp[n-1]
}