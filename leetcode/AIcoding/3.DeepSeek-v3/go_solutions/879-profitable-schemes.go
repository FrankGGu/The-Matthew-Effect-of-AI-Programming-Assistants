func profitableSchemes(n int, minProfit int, group []int, profit []int) int {
    const mod = 1e9 + 7
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, minProfit+1)
        dp[i][0] = 1
    }

    for k := 0; k < len(group); k++ {
        g := group[k]
        p := profit[k]
        for i := n; i >= g; i-- {
            for j := minProfit; j >= 0; j-- {
                newProfit := min(j + p, minProfit)
                dp[i][j] = (dp[i][j] + dp[i-g][newProfit]) % mod
            }
        }
    }

    return dp[n][minProfit]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}