package main

func dominoGame(piles [][]int) int {
    dp := make([]int, 2)
    for i := len(piles) - 1; i >= 0; i-- {
        dp[0], dp[1] = max(dp[1]+piles[i][0], dp[0]), max(dp[0]+piles[i][1], dp[1])
    }
    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}