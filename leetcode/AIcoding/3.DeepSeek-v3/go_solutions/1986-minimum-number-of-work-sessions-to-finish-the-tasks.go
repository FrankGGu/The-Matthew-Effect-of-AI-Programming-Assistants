func minSessions(tasks []int, sessionTime int) int {
    n := len(tasks)
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = n
    }
    dp[0] = 0
    valid := make([]bool, 1<<n)
    for mask := 1; mask < 1<<n; mask++ {
        sum := 0
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                sum += tasks[i]
            }
        }
        if sum <= sessionTime {
            valid[mask] = true
        }
    }
    for mask := 1; mask < 1<<n; mask++ {
        for subset := mask; subset > 0; subset = (subset - 1) & mask {
            if valid[subset] {
                if dp[mask^subset]+1 < dp[mask] {
                    dp[mask] = dp[mask^subset] + 1
                }
            }
        }
    }
    return dp[1<<n-1]
}