func new21Game(n int, k int, maxPts int) float64 {
    if k == 0 || n >= k {
        return 1.0
    }

    dp := make([]float64, n+1)
    dp[0] = 1.0
    sum := dp[0]

    for i := 1; i <= n; i++ {
        if i - maxPts - 1 >= 0 {
            sum -= dp[i-maxPts-1]
        }
        dp[i] = sum / float64(maxPts)
        if i < k {
            sum += dp[i]
        }
    }

    result := 0.0
    for i := k; i <= n; i++ {
        result += dp[i]
    }

    return result
}