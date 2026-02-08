func minCost(paints [][]int, m int, n int, target int) int {
    dp := make([][][]int, m+1)
    for i := range dp {
        dp[i] = make([][]int, target+1)
        for j := range dp[i] {
            dp[i][j] = make([]int, n+1)
            for k := range dp[i][j] {
                dp[i][j][k] = math.MaxInt32
            }
        }
    }
    dp[0][0][0] = 0

    for i := 0; i < m; i++ {
        for j := 0; j <= target; j++ {
            for k := 0; k < n; k++ {
                if dp[i][j][k] == math.MaxInt32 {
                    continue
                }
                for color := 0; color < n; color++ {
                    cost := dp[i][j][k] + paints[i][color]
                    if color == k {
                        dp[i+1][j][color] = min(dp[i+1][j][color], cost)
                    } else {
                        if j+1 <= target {
                            dp[i+1][j+1][color] = min(dp[i+1][j+1][color], cost)
                        }
                    }
                }
            }
        }
    }

    result := math.MaxInt32
    for k := 0; k < n; k++ {
        result = min(result, dp[m][target][k])
    }
    if result == math.MaxInt32 {
        return -1
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}