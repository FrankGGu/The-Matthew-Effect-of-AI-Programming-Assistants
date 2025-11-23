func maxTaxiEarnings(n int, rides [][]int) int64 {
    sort.Slice(rides, func(i, j int) bool {
        return rides[i][1] < rides[j][1]
    })

    dp := make([]int64, n+1)
    j := 0
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j < len(rides) && rides[j][1] == i {
            start, end, tip := rides[j][0], rides[j][1], rides[j][2]
            earnings := int64(end - start + tip)
            if dp[start] + earnings > dp[i] {
                dp[i] = dp[start] + earnings
            }
            j++
        }
    }
    return dp[n]
}