package main

func minCost(n int, cuts []int) int {
    sort.Ints(cuts)
    cuts = append([]int{0}, cuts...)
    cuts = append(cuts, n)
    m := len(cuts)
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, m)
    }
    for length := 2; length < m; length++ {
        for i := 0; i < m-length; i++ {
            j := i + length
            dp[i][j] = math.MaxInt32
            for k := i + 1; k < j; k++ {
                dp[i][j] = min(dp[i][j], dp[i][k]+dp[k][j]+cuts[j]-cuts[i])
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