func minPaintCost(cost [][]int, n int) int {
    if n == 0 {
        return 0
    }
    dp := make([][3]int, n)
    dp[0] = [3]int{cost[0][0], cost[0][1], cost[0][2]}

    for i := 1; i < n; i++ {
        dp[i][0] = cost[i][0] + min(dp[i-1][1], dp[i-1][2])
        dp[i][1] = cost[i][1] + min(dp[i-1][0], dp[i-1][2])
        dp[i][2] = cost[i][2] + min(dp[i-1][0], dp[i-1][1])
    }

    return min(min(dp[n-1][0], dp[n-1][1]), dp[n-1][2])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}