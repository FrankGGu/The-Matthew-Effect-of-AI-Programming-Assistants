func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func mostPoints(questions [][]int) int64 {
    n := len(questions)
    dp := make([]int64, n+1)

    for i := n - 1; i >= 0; i-- {
        points := int64(questions[i][0])
        brainpower := questions[i][1]

        nextIndex := i + brainpower + 1
        if nextIndex < n {
            dp[i] = points + dp[nextIndex]
        } else {
            dp[i] = points
        }

        dp[i] = int64(max(int(dp[i]), int(dp[i+1])))
    }

    return dp[0]
}