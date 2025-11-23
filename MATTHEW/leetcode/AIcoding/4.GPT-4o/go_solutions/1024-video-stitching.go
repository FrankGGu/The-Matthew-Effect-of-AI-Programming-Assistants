func videoStitching(clips [][]int, T int) int {
    dp := make([]int, T+1)
    for i := range dp {
        dp[i] = 1e9
    }
    dp[0] = 0

    for _, clip := range clips {
        start, end := clip[0], clip[1]
        if end > T {
            end = T
        }
        for j := end; j >= start; j-- {
            dp[j] = min(dp[j], dp[start]+1)
        }
    }

    if dp[T] == 1e9 {
        return -1
    }
    return dp[T]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}