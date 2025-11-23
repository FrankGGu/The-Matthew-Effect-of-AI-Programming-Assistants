func trainingPlan(n int, m int, x int, gains []int) int {
    dp := make([]int, x+1)
    for _, gain := range gains {
        for j := x; j >= gain; j-- {
            dp[j] = max(dp[j], dp[j-gain]+1)
        }
    }
    return dp[x]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}