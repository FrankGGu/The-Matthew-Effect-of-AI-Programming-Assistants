package main

func minFinishTime(poses []int, times []int) int {
    n := len(poses)
    dp := make([]float64, n)
    for i := 0; i < n; i++ {
        dp[i] = float64(times[i])
    }
    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            if poses[j] == i {
                dp[i] = min(dp[i], dp[j]+float64(times[i]))
            }
        }
    }
    res := math.MaxInt
    for i := 0; i < n; i++ {
        if poses[i] == n-1 {
            res = min(res, int(dp[i]))
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}