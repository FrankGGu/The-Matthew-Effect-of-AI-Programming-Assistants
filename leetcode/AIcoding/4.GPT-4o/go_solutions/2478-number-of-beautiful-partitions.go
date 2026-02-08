func countBeautifulPartitions(s string, k int, minLength int) int {
    MOD := 1000000007
    n := len(s)
    if s[0] == '0' || s[n-1] == '0' {
        return 0
    }

    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int)(n + 1)
    }
    dp[0][0] = 1

    for i := 1; i <= k; i++ {
        for j := 1; j <= n; j++ {
            if s[j-1] == '1' {
                for l := minLength; l <= j; l++ {
                    dp[i][j] = (dp[i][j] + dp[i-1][j-l]) % MOD
                }
            }
        }
    }

    return dp[k][n]
}