func getMoneyAmount(n int) int {
    dp := make([][]int, n+2)
    for i := range dp {
        dp[i] = make([]int, n+2)
    }

    for length := 2; length <= n; length++ {
        for i := 1; i <= n - length + 1; i++ {
            j := i + length - 1
            dp[i][j] = math.MaxInt32
            for k := i; k <= j; k++ {
                cost := k + max(dp[i][k-1], dp[k+1][j])
                if cost < dp[i][j] {
                    dp[i][j] = cost
                }
            }
        }
    }

    return dp[1][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}