func numPermsDISequence(s string) int {
    n := len(s)
    mod := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        for j := 0; j <= i; j++ {
            if s[i-1] == 'D' {
                for k := j; k < i; k++ {
                    dp[i][j] = (dp[i][j] + dp[i-1][k]) % mod
                }
            } else {
                for k := 0; k < j; k++ {
                    dp[i][j] = (dp[i][j] + dp[i-1][k]) % mod
                }
            }
        }
    }
    res := 0
    for j := 0; j <= n; j++ {
        res = (res + dp[n][j]) % mod
    }
    return res
}