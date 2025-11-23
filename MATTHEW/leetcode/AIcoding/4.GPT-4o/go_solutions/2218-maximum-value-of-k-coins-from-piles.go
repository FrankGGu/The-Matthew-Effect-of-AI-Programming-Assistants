func maxCoins(piles [][]int, k int) int {
    n := len(piles)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            for x := 0; x <= len(piles[i-1]) && x <= j; x++ {
                dp[i][j] = max(dp[i][j], dp[i-1][j-x]+sum(piles[i-1][:x]))
            }
        }
    }

    return dp[n][k]
}

func sum(arr []int) int {
    total := 0
    for _, v := range arr {
        total += v
    }
    return total
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}