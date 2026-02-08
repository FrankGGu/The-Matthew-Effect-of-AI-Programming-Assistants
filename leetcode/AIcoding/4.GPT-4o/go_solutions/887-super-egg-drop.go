func superEggDrop(K int, N int) int {
    dp := make([][]int, K+1)
    for i := range dp {
        dp[i] = make([]int, N+1)
    }

    for i := 1; i <= K; i++ {
        dp[i][0] = 0
        dp[i][1] = 1
    }
    for j := 1; j <= N; j++ {
        dp[1][j] = j
    }

    for i := 2; i <= K; i++ {
        for j := 2; j <= N; j++ {
            dp[i][j] = j
            for x := 1; x <= j; x++ {
                res := 1 + max(dp[i-1][x-1], dp[i][j-x])
                if res < dp[i][j] {
                    dp[i][j] = res
                }
            }
        }
    }
    return dp[K][N]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}