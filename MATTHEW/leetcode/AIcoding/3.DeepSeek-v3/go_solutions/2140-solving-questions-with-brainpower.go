func mostPoints(questions [][]int) int64 {
    n := len(questions)
    dp := make([]int64, n+1)

    for i := n - 1; i >= 0; i-- {
        points, skip := int64(questions[i][0]), int64(questions[i][1])
        next := i + int(skip) + 1
        if next > n {
            next = n
        }
        dp[i] = max(points + dp[next], dp[i+1])
    }

    return dp[0]
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}