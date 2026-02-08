func mostPoints(questions [][]int) int64 {
    n := len(questions)
    dp := make([]int64, n+1)

    for i := n - 1; i >= 0; i-- {
        dp[i] = max(dp[i+1], int64(questions[i][0])+dp[min(i+questions[i][1]+1, n)])
    }

    return dp[0]
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}