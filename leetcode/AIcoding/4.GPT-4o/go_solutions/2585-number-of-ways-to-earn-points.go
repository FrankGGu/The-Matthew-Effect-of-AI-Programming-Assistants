func waysToEarnPoints(points []int, target int) int {
    dp := make([]int, target+1)
    dp[0] = 1

    for _, p := range points {
        for j := p; j <= target; j++ {
            dp[j] += dp[j-p]
        }
    }

    return dp[target]
}