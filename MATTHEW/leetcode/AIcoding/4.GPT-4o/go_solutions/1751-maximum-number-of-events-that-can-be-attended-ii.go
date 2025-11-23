func maxValue(events [][]int, k int) int {
    n := len(events)
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    sort.Slice(events, func(i, j int) bool {
        return events[i][1] < events[j][1]
    })

    for i := 1; i <= k; i++ {
        for j := 1; j <= n; j++ {
            dp[i][j] = dp[i][j-1]
            startTime := events[j-1][0]
            endTime := events[j-1][1]
            value := events[j-1][2]

            l := 0
            r := j - 1
            for l < r {
                mid := (l + r) / 2
                if events[mid][1] < startTime {
                    l = mid + 1
                } else {
                    r = mid
                }
            }
            if l > 0 && events[l-1][1] < startTime {
                dp[i][j] = max(dp[i][j], dp[i-1][l]+value)
            } else if l == 0 {
                dp[i][j] = max(dp[i][j], value)
            }
        }
    }

    return dp[k][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}