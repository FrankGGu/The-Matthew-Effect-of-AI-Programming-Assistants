package main

func uniquePathsWithObstacles(obstacleGrid [][]int) int {
    if obstacleGrid == nil || len(obstacleGrid) == 0 || len(obstacleGrid[0]) == 0 {
        return 0
    }
    m, n := len(obstacleGrid), len(obstacleGrid[0])
    dp := make([]int, n)
    for j := 0; j < n; j++ {
        if obstacleGrid[0][j] == 1 {
            break
        }
        dp[j] = 1
    }
    for i := 1; i < m; i++ {
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