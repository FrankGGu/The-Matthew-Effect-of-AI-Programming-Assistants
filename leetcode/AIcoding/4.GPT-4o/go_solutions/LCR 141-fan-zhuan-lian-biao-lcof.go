func workoutPlan(need []int, n int) []int {
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j := 0; j < 3; j++ {
            if i >= need[j] {
                dp[i] = max(dp[i], dp[i-need[j]]+need[j])
            }
        }
    }
    result := []int{}
    for i := n; i > 0; {
        for j := 0; j < 3; j++ {
            if i >= need[j] && dp[i] == dp[i-need[j]]+need[j] {
                result = append(result, need[j])
                i -= need[j]
                break
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}