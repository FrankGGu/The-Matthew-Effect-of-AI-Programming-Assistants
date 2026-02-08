package main

func findWinningPlayer(coinGame []int) int {
    n := len(coinGame)
    if n == 0 {
        return -1
    }
    if n == 1 {
        return 0
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        dp[i][i] = coinGame[i]
    }
    for l := 2; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            dp[i][j] = max(coinGame[i]-dp[i+1][j], coinGame[j]-dp[i][j-1])
        }
    }
    if dp[0][n-1] > 0 {
        return 0
    } else if dp[0][n-1] < 0 {
        return 1
    } else {
        return 0
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}