func minFallingPathSum(grid [][]int) int {
    n := len(grid)
    if n == 1 {
        return grid[0][0]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        copy(dp[i], grid[i])
    }

    for i := 1; i < n; i++ {
        firstMin, secondMin := -1, -1
        for j := 0; j < n; j++ {
            if firstMin == -1 || dp[i-1][j] < dp[i-1][firstMin] {
                secondMin = firstMin
                firstMin = j
            } else if secondMin == -1 || dp[i-1][j] < dp[i-1][secondMin] {
                secondMin = j
            }
        }

        for j := 0; j < n; j++ {
            if j != firstMin {
                dp[i][j] += dp[i-1][firstMin]
            } else {
                dp[i][j] += dp[i-1][secondMin]
            }
        }
    }

    res := dp[n-1][0]
    for j := 1; j < n; j++ {
        if dp[n-1][j] < res {
            res = dp[n-1][j]
        }
    }
    return res
}