package main

func stoneGame(piles []int) bool {
    n := len(piles)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        dp[i][i] = piles[i]
    }
    for l := 2; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            dp[i][j] = max(piles[i]-dp[i+1][j], piles[j]-dp[i][j-1])
        }
    }
    return dp[0][n-1] > 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}