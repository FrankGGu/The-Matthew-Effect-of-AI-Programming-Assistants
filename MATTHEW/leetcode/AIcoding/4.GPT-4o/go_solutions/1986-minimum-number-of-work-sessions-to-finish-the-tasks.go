func minSessions(tasks []int, sessionTime int) int {
    n := len(tasks)
    maxState := 1 << n
    dp := make([]int, maxState)
    for i := range dp {
        dp[i] = n + 1
    }
    dp[0] = 0

    for state := 0; state < maxState; state++ {
        for j := 0; j < n; j++ {
            if state&(1<<j) == 0 {
                nextState := state | (1 << j)
                time := 0
                for k := 0; k < n; k++ {
                    if nextState&(1<<k) != 0 {
                        time += tasks[k]
                    }
                }
                if time <= sessionTime {
                    dp[nextState] = min(dp[nextState], dp[state]+1)
                }
            }
        }
    }

    return dp[maxState-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}