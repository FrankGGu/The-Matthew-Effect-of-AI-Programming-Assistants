import "sort"

func maxValue(events [][]int, k int) int {
    n := len(events)
    sort.Slice(events, func(i, j int) bool {
        return events[i][1] < events[j][1]
    })

    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 1; i <= n; i++ {
        start, end, val := events[i-1][0], events[i-1][1], events[i-1][2]
        last := sort.Search(i, func(j int) bool {
            return events[j][1] >= start
        })

        for j := 1; j <= k; j++ {
            dp[i][j] = max(dp[i-1][j], dp[last][j-1] + val)
        }
    }

    return dp[n][k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}