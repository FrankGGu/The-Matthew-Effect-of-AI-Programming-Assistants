func stoneGameVIII(stones []int) int {
    n := len(stones)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + stones[i]
    }

    dp := make([]int, n)
    dp[n-1] = prefix[n]

    for i := n-2; i >= 1; i-- {
        dp[i] = max(dp[i+1], prefix[i+1] - dp[i+1])
    }

    return dp[1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}