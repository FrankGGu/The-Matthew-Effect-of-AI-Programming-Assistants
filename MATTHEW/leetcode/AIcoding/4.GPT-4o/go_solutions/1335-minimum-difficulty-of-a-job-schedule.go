func minDifficulty(jobDifficulty []int, d int) int {
    n := len(jobDifficulty)
    if n < d {
        return -1
    }

    dp := make([][]int, d+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }
    dp[0][0] = 0

    for day := 1; day <= d; day++ {
        for j := day; j <= n; j++ {
            maxJobDifficulty := 0
            for k := j; k >= day; k-- {
                maxJobDifficulty = max(maxJobDifficulty, jobDifficulty[k-1])
                dp[day][j] = min(dp[day][j], dp[day-1][k-1]+maxJobDifficulty)
            }
        }
    }

    return dp[d][n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}