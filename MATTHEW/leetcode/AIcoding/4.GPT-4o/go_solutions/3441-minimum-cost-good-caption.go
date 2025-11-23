func minCost(captions []int, cost [][]int) int {
    n := len(captions)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = int(1e9)
        for j := 1; j <= i; j++ {
            dp[i] = min(dp[i], dp[i-j]+cost[j-1][captions[i-1]-1])
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