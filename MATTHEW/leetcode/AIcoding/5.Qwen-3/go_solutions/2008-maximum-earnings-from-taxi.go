package main

func maxTaxiEarnings(n int, rides []int) int {
    sort.Slice(rides, func(i, j int) bool {
        return rides[i][1] < rides[j][1]
    })

    dp := make([]int, n+1)
    for i := 0; i < len(rides); i++ {
        start, end, earn := rides[i][0], rides[i][1], rides[i][2]
        dp[end] = max(dp[end], dp[start]+earn)
        dp[end] = max(dp[end], dp[end-1])
    }

    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}