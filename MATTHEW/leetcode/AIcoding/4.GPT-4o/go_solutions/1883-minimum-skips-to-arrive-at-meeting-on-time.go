func minSkips(dist []int, speed int, hoursBefore int) int {
    n := len(dist)
    dp := make([][]float64, n+1)
    for i := range dp {
        dp[i] = make([]float64, n+1)
        for j := range dp[i] {
            dp[i][j] = math.Inf(1)
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 0; j <= i; j++ {
            if j > 0 {
                dp[i][j] = min(dp[i][j], dp[i-1][j-1])
            }
            dp[i][j] = min(dp[i][j], dp[i-1][j]+float64(dist[i-1])/float64(speed))
            if dp[i][j] > float64(hoursBefore) {
                dp[i][j] = math.Inf(1)
            }
        }
    }

    for j := 0; j <= n; j++ {
        if dp[n][j] <= float64(hoursBefore) {
            return j
        }
    }
    return n
}

func min(a, b float64) float64 {
    if a < b {
        return a
    }
    return b
}