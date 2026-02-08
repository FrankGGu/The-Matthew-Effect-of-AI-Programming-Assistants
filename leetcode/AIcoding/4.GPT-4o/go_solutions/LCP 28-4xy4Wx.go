func profitableSchemes(n int, minProfit int, group []int, profit []int) int {
    const mod = 1_000_000_007
    dp := make([]int, minProfit+1)
    dp[0] = 1

    for i := 0; i < len(group); i++ {
        g, p := group[i], profit[i]
        for j := n; j >= g; j-- {
            for k := minProfit; k >= 0; k-- {
                newProfit := k + p
                if newProfit > minProfit {
                    newProfit = minProfit
                }
                dp[newProfit] = (dp[newProfit] + dp[k]) % mod
            }
        }
    }

    total := 0
    for i := 0; i <= n; i++ {
        total = (total + dp[minProfit]) % mod
    }

    return total
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}