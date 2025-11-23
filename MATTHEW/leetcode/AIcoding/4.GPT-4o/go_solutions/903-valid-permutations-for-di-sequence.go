func numPermsDISequence(S string) int {
    n := len(S)
    mod := int(1e9 + 7)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1

    for i := 0; i < n; i++ {
        if S[i] == 'I' {
            for j := 0; j <= i; j++ {
                for k := j + 1; k <= i+1; k++ {
                    dp[i+1][k] = (dp[i+1][k] + dp[i][j]) % mod
                }
            }
        } else {
            for j := 0; j <= i; j++ {
                for k := 0; k < j; k++ {
                    dp[i+1][k] = (dp[i+1][k] + dp[i][j]) % mod
                }
            }
        }
    }

    result := 0
    for i := 0; i <= n; i++ {
        result = (result + dp[n][i]) % mod
    }

    return result
}