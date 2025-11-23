func earliestTimeToTrigger(events [][]int) int {
    n := len(events)
    if n == 0 {
        return 0
    }

    sort.Slice(events, func(i, j int) bool {
        return events[i][0] < events[j][0]
    })

    dp := make([]int, n)
    dp[0] = events[0][0] + events[0][1]

    for i := 1; i < n; i++ {
        dp[i] = events[i][0] + events[i][1]
        for j := i - 1; j >= 0; j-- {
            if events[j][0] + events[j][1] <= events[i][0] {
                dp[i] = min(dp[i], dp[j] + events[i][1])
                break
            }
        }
    }

    result := dp[0]
    for i := 1; i < n; i++ {
        result = min(result, dp[i])
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}