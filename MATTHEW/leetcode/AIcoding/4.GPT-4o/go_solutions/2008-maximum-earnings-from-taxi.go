func maxTaxiEarnings(n int, rides [][]int) int64 {
    dp := make([]int64, n+1)
    for _, ride := range rides {
        start, end, tip := ride[0], ride[1], ride[2]
        dp[end] = max(dp[end], dp[start]+int64(end-start+tip))
    }
    for i := 1; i <= n; i++ {
        dp[i] = max(dp[i], dp[i-1])
    }
    return dp[n]
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}