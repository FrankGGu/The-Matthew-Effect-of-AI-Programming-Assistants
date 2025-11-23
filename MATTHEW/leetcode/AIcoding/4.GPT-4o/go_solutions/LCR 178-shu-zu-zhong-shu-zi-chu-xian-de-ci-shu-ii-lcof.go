func trainingPlanVI(n int, m int, sessions [][]int) int {
    dp := make([]int, m+1)
    for i := 0; i < n; i++ {
        for j := m; j >= sessions[i][0]; j-- {
            dp[j] = max(dp[j], dp[j-sessions[i][0]]+sessions[i][1])
        }
    }
    return dp[m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}