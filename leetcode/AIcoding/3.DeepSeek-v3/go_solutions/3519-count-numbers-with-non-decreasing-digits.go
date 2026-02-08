func countNumbersWithNonDecreasingDigits(n int) int {
    if n == 0 {
        return 1
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 10)
    }
    for j := 0; j <= 9; j++ {
        dp[1][j] = 1
    }
    for i := 2; i <= n; i++ {
        for j := 0; j <= 9; j++ {
            for k := 0; k <= j; k++ {
                dp[i][j] += dp[i-1][k]
            }
        }
    }
    res := 0
    for i := 1; i <= n; i++ {
        for j := 0; j <= 9; j++ {
            res += dp[i][j]
        }
    }
    return res + 1
}