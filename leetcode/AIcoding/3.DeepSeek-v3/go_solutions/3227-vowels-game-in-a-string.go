func countVowelStrings(n int) int {
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 5)
    }
    for j := 0; j < 5; j++ {
        dp[1][j] = 1
    }
    for i := 2; i <= n; i++ {
        for j := 0; j < 5; j++ {
            for k := 0; k <= j; k++ {
                dp[i][j] += dp[i-1][k]
            }
        }
    }
    res := 0
    for j := 0; j < 5; j++ {
        res += dp[n][j]
    }
    return res
}