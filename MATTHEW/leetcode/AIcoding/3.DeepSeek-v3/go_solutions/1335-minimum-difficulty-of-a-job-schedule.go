func minDifficulty(jobDifficulty []int, d int) int {
    n := len(jobDifficulty)
    if n < d {
        return -1
    }

    dp := make([][]int, d+1)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }

    max := 0
    for i := 0; i < n; i++ {
        if jobDifficulty[i] > max {
            max = jobDifficulty[i]
        }
        dp[1][i] = max
    }

    for day := 2; day <= d; day++ {
        for i := day-1; i < n; i++ {
            max := 0
            for j := i; j >= day-1; j-- {
                if jobDifficulty[j] > max {
                    max = jobDifficulty[j]
                }
                if dp[day-1][j-1] + max < dp[day][i] {
                    dp[day][i] = dp[day-1][j-1] + max
                }
            }
        }
    }

    return dp[d][n-1]
}