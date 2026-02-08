func minPathCost(grid [][]int, moveCost [][]int) int {
    rows, cols := len(grid), len(grid[0])
    dp := make([][]int, rows)
    for i := range dp {
        dp[i] = make([]int, cols)
    }

    for j := 0; j < cols; j++ {
        dp[0][j] = grid[0][j]
    }

    for i := 1; i < rows; i++ {
        for j := 0; j < cols; j++ {
            minCost := int(1e9)
            for k := 0; k < cols; k++ {
                cost := dp[i-1][k] + grid[i][j] + moveCost[k][j]
                if cost < minCost {
                    minCost = cost
                }
            }
            dp[i][j] = minCost
        }
    }

    result := int(1e9)
    for j := 0; j < cols; j++ {
        if dp[rows-1][j] < result {
            result = dp[rows-1][j]
        }
    }

    return result
}