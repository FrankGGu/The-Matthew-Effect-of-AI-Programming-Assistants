func canCompletePlan(n int, m int, plan [][]int) bool {
    dp := make([]int, n+1)
    for _, p := range plan {
        for i := n; i >= p[0]; i-- {
            dp[i] = max(dp[i], dp[i-p[0]]+p[1])
        }
    }
    return dp[n] >= m
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}