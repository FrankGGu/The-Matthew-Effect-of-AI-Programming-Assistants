func largestSumOfAverages(A []float64, K int) float64 {
    n := len(A)
    dp := make([]float64, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + A[i-1]
    }

    sum := make([]float64, n+1)
    for i := 1; i <= n; i++ {
        sum[i] = sum[i-1] + A[i-1]
    }

    avg := make([][]float64, n+1)
    for i := 1; i <= n; i++ {
        avg[i] = make([]float64, K+1)
        for k := 1; k <= K; k++ {
            if k > i {
                avg[i][k] = 0
                continue
            }
            for j := k - 1; j < i; j++ {
                avg[i][k] = max(avg[i][k], avg[j][k-1]+(sum[i]-sum[j])/(float64(i-j)))
            }
        }
    }

    return avg[n][K]
}

func max(a, b float64) float64 {
    if a > b {
        return a
    }
    return b
}