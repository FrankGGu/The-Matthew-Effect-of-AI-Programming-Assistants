func maxCoins(bags []int, k int) int {
    sort.Ints(bags)
    n := len(bags)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            if i >= 2*j {
                sum := bags[i-1] + bags[i-2]
                dp[i][j] = max(dp[i-1][j], dp[i-2][j-1]+sum)
            } else if i == 2*j-1 {
                sum := bags[i-1] + bags[i-2]
                dp[i][j] = dp[i-2][j-1] + sum
            } else {
                dp[i][j] = dp[i-1][j]
            }
        }
    }

    return dp[n][k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}