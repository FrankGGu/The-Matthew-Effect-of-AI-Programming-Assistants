func getMoneyAmount(n int) int {
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for length := 2; length <= n; length++ {
        for start := 1; start <= n-length+1; start++ {
            end := start + length - 1
            dp[start][end] = math.MaxInt32
            for pick := start; pick <= end; pick++ {
                cost := pick + max(dp[start][pick-1], dp[pick+1][end])
                dp[start][end] = min(dp[start][end], cost)
            }
        }
    }

    return dp[1][n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}