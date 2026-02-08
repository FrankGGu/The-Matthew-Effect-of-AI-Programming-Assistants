func profitableSchemes(G int, P int, group []int, profit []int) int {
    const mod = 1_000_000_007
    dp := make([][]int, G+1)
    for i := range dp {
        dp[i] = make([]int, P+1)
    }
    dp[0][0] = 1

    for i := 0; i < len(group); i++ {
        g, p := group[i], profit[i]
        for j := G; j >= g; j-- {
            for k := 0; k <= P; k++ {
                newProfit := min(k+p, P)
                dp[j][newProfit] = (dp[j][newProfit] + dp[j-g][k]) % mod
            }
        }
    }

    result := 0
    for j := 0; j <= G; j++ {
        result = (result + dp[j][P]) % mod
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}