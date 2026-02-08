package main

func minDifficulty(jobDifficulty []int, d int) int {
    n := len(jobDifficulty)
    if n < d {
        return -1
    }
    dp := make([][]int, d+1)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    dp[0][0] = jobDifficulty[0]
    for i := 1; i < n; i++ {
        dp[0][i] = max(dp[0][i-1], jobDifficulty[i])
    }
    for day := 1; day < d; day++ {
        for start := 0; start <= n-day; start++ {
            minVal := math.MaxInt32
            currentMax := 0
            for end := start; end <= n-day; end++ {
                currentMax = max(currentMax, jobDifficulty[end])
                minVal = min(minVal, dp[day-1][end]+currentMax)
            }
            dp[day][start] = minVal
        }
    }
    return dp[d-1][0]
}

func max(a, b int) int {
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