func minCost(n int, cuts []int) int {
    cuts = append(cuts, 0, n)
    sort.Ints(cuts)
    m := len(cuts)
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, m)
    }
    for l := 2; l < m; l++ {
        for i := 0; i < m-l; i++ {
            j := i + l
            dp[i][j] = math.MaxInt32
            for k := i + 1; k < j; k++ {
                cost := dp[i][k] + dp[k][j] + cuts[j] - cuts[i]
                if cost < dp[i][j] {
                    dp[i][j] = cost
                }
            }
        }
    }
    return dp[0][m-1]
}