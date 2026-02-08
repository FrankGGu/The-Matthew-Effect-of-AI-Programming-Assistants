func countSets(n int, k int, L int, R int) int {
    mod := 1_000_000_007
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1

    for i := 1; i <= k; i++ {
        for j := 1; j <= n; j++ {
            dp[i][j] = dp[i][j-1]
            if j >= L {
                dp[i][j] = (dp[i][j] + dp[i-1][j-L]) % mod
            }
            if j >= R+1 {
                dp[i][j] = (dp[i][j] - dp[i-1][j-R-1] + mod) % mod
            }
        }
    }

    result := 0
    for j := L; j <= n; j++ {
        result = (result + dp[k][j]) % mod
    }

    return result
}