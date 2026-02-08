package main

func stoneGameV(stoneStr string) int {
    stones := []byte(stoneStr)
    n := len(stones)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    sum := make([]int, n+1)
    for i := 0; i < n; i++ {
        sum[i+1] = sum[i] + int(stones[i])
    }
    for l := 2; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            total := sum[j+1] - sum[i]
            for k := i; k < j; k++ {
                left := sum[k+1] - sum[i]
                right := total - left
                if left < right {
                    dp[i][j] = max(dp[i][j], dp[i][k]+left)
                } else if left > right {
                    dp[i][j] = max(dp[i][j], dp[k+1][j]+right)
                } else {
                    dp[i][j] = max(dp[i][j], dp[i][k]+left)
                    dp[i][j] = max(dp[i][j], dp[k+1][j]+right)
                }
            }
        }
    }
    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}