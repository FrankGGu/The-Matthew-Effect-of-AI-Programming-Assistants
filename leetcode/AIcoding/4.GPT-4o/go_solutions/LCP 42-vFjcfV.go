func playGame(toys []int) int {
    n := len(toys)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = toys[0]

    for i := 1; i < n; i++ {
        dp[i] = max(dp[i-1], toys[i])
        if i > 1 {
            dp[i] = max(dp[i], dp[i-2]+toys[i])
        }
    }

    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}