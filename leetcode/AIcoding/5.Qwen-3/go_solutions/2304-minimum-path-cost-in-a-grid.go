package main

func minPathCost(grid [][]int, moveCost [][]int) int {
    m := len(grid)
    n := len(grid[0])

    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    copy(dp[0], grid[0])

    for i := 1; i < m; i++ {
        for j := 0; j < n; j++ {
            minPrev := math.MaxInt32
            for k := 0; k < n; k++ {
                if dp[i-1][k] < minPrev {
                    minPrev = dp[i-1][k]
                }
            }
            dp[i][j] = minPrev + moveCost[grid[i-1][j]][j] + grid[i][j]
        }
    }

    minVal := math.MaxInt32
    for _, val := range dp[m-1] {
        if val < minVal {
            minVal = val
        }
    }

    return minVal
}