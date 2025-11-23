func minCost(transport []int, cost [][]int) int {
    n := len(transport)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for i := 1; i <= n; i++ {
        for j := 0; j < i; j++ {
            dp[i] = min(dp[i], dp[j]+cost[j][i-1])
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}