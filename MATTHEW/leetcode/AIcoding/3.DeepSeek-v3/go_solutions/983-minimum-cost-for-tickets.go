func mincostTickets(days []int, costs []int) int {
    maxDay := days[len(days)-1]
    dp := make([]int, maxDay+1)
    dayIdx := 0

    for i := 1; i <= maxDay; i++ {
        if i == days[dayIdx] {
            oneDay := dp[i-1] + costs[0]
            sevenDay := costs[1]
            if i >= 7 {
                sevenDay += dp[i-7]
            }
            thirtyDay := costs[2]
            if i >= 30 {
                thirtyDay += dp[i-30]
            }
            dp[i] = min(oneDay, min(sevenDay, thirtyDay))
            dayIdx++
            if dayIdx >= len(days) {
                break
            }
        } else {
            dp[i] = dp[i-1]
        }
    }
    return dp[maxDay]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}