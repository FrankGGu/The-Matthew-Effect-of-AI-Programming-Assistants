func minSkips(dist []int, speed int, hoursBefore int) int {
    n := len(dist)
    eps := 1e-7
    dp := make([][]float64, n+1)
    for i := range dp {
        dp[i] = make([]float64, n+1)
        for j := range dp[i] {
            dp[i][j] = 1e20
        }
    }
    dp[0][0] = 0.0
    for i := 1; i <= n; i++ {
        d := float64(dist[i-1]) / float64(speed)
        for j := 0; j <= i; j++ {
            if j < i {
                dp[i][j] = math.Ceil(dp[i-1][j]+d - eps)
            }
            if j > 0 {
                if dp[i-1][j-1]+d < dp[i][j] {
                    dp[i][j] = dp[i-1][j-1] + d
                }
            }
        }
    }
    for skips := 0; skips <= n; skips++ {
        if dp[n][skips] <= float64(hoursBefore) + eps {
            return skips
        }
    }
    return -1
}