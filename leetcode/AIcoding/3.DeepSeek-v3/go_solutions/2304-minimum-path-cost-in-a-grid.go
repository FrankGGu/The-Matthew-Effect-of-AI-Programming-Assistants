func minPathCost(grid [][]int, moveCost [][]int) int {
    m := len(grid)
    n := len(grid[0])

    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for j := 0; j < n; j++ {
        dp[0][j] = grid[0][j]
    }

    for i := 1; i < m; i++ {
        for j := 0; j < n; j++ {
            minCost := math.MaxInt32
            for k := 0; k < n; k++ {
                cost := dp[i-1][k] + moveCost[grid[i-1][k]][j] + grid[i][j]
                if cost < minCost {
                    minCost = cost
                }
            }
            dp[i][j] = minCost
        }
    }

    result := math.MaxInt32
    for j := 0; j < n; j++ {
        if dp[m-1][j] < result {
            result = dp[m-1][j]
        }
    }

    return result
}