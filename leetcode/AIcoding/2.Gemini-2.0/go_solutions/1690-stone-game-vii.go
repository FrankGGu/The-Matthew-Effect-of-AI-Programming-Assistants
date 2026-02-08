func stoneGameVII(stones []int) int {
    n := len(stones)
    sum := make([]int, n+1)
    for i := 0; i < n; i++ {
        sum[i+1] = sum[i] + stones[i]
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            dp[i][j] = max(sum[j+1]-sum[i+1]-dp[i+1][j], sum[j]-sum[i]-dp[i][j-1])
        }
    }
    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}