package main

func mincostTickets(prices []int, days []int) int {
    dp := make([]int, 366)
    daySet := make(map[int]bool)
    for _, day := range days {
        daySet[day] = true
    }
    for i := 1; i <= 365; i++ {
        if !daySet[i] {
            dp[i] = dp[i-1]
            continue
        }
        dp[i] = dp[i-1] + prices[0]
        if i >= 7 {
            dp[i] = min(dp[i], dp[i-7]+prices[1])
        } else {
            dp[i] = min(dp[i], prices[1])
        }
        if i >= 30 {
            dp[i] = min(dp[i], dp[i-30]+prices[2])
        } else {
            dp[i] = min(dp[i], prices[2])
        }
    }
    return dp[365]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}