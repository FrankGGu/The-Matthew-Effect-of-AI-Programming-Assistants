func minCost(n int, cuts []int) int {
    cuts = append(cuts, 0, n)
    sort.Ints(cuts)
    m := len(cuts)

    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, m)
    }

    for length := 2; length < m; length++ {
        for left := 0; left < m-length; left++ {
            right := left + length
            dp[left][right] = math.MaxInt32
            for i := left + 1; i < right; i++ {
                dp[left][right] = min(dp[left][right], cuts[right] - cuts[left] + dp[left][i] + dp[i][right])
            }
        }
    }

    return dp[0][m-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}