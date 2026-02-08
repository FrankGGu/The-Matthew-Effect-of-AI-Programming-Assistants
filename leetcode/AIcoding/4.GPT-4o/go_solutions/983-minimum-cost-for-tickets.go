func mincostTickets(days []int, costs []int) int {
    dp := make([]int, days[len(days)-1]+1)
    daySet := make(map[int]struct{})
    for _, day := range days {
        daySet[day] = struct{}{}
    }

    for i := 1; i < len(dp); i++ {
        if _, ok := daySet[i]; ok {
            dp[i] = min(dp[i-1]+costs[0], min(dp[max(0, i-7)]+costs[1], dp[max(0, i-30)]+costs[2]))
        } else {
            dp[i] = dp[i-1]
        }
    }
    return dp[len(dp)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}