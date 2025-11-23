func soupServings(N int) float64 {
    if N > 5000 {
        return 1.0
    }
    dp := make([][]float64, 200)
    for i := range dp {
        dp[i] = make([]float64, 200)
    }
    return calculate(N, dp)
}

func calculate(a int, b int, dp [][]float64) float64 {
    if a <= 0 && b <= 0 {
        return 0.5
    }
    if a <= 0 {
        return 1.0
    }
    if b <= 0 {
        return 0.0
    }
    if dp[a][b] != 0 {
        return dp[a][b]
    }

    dp[a][b] = 0.25 * (calculate(a-100, b, dp) + calculate(a-75, b-25, dp) + calculate(a-50, b-50, dp) + calculate(a-25, b-75, dp))
    return dp[a][b]
}