func maximumContainers(containers []int, itemsPerContainer int, cargoSize int) int {
    n := len(containers)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, cargoSize+1)
    }

    for i := 1; i <= n; i++ {
        for j := 0; j <= cargoSize; j++ {
            dp[i][j] = dp[i-1][j]
            if j >= 1 {
                maxTake := min(containers[i-1], j*itemsPerContainer)
                for k := 1; k <= maxTake; k++ {
                    if j - (k + itemsPerContainer - 1) / itemsPerContainer >= 0 {
                        if dp[i-1][j - (k + itemsPerContainer - 1) / itemsPerContainer] + k > dp[i][j] {
                            dp[i][j] = dp[i-1][j - (k + itemsPerContainer - 1) / itemsPerContainer] + k
                        }
                    }
                }
            }
        }
    }

    return dp[n][cargoSize]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}