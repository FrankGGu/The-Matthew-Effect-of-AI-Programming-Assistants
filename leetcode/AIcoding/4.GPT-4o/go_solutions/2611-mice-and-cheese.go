func miceAndCheese(mouse []int, cheese []int) int {
    n := len(mouse)
    dp := make([]int, n+1)

    for i := 0; i < n; i++ {
        dp[i+1] = dp[i] + mouse[i]
        if i > 0 {
            dp[i+1] = max(dp[i+1], dp[i-1]+cheese[i-1])
        }
    }

    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}