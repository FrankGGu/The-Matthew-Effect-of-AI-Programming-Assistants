func numOfArrays(n int, m int, k int) int {
    const mod = 1e9 + 7
    if k == 0 {
        return 0
    }
    dp := make([][][]int, n+1)
    for i := range dp {
        dp[i] = make([][]int, m+1)
        for j := range dp[i] {
            dp[i][j] = make([]int, k+1)
        }
    }
    for j := 1; j <= m; j++ {
        dp[1][j][1] = 1
    }
    for i := 2; i <= n; i++ {
        for j := 1; j <= m; j++ {
            for l := 1; l <= k; l++ {
                sum := 0
                sum = (sum + dp[i-1][j][l]*j) % mod
                for p := 1; p < j; p++ {
                    sum = (sum + dp[i-1][p][l-1]) % mod
                }
                dp[i][j][l] = sum
            }
        }
    }
    res := 0
    for j := 1; j <= m; j++ {
        res = (res + dp[n][j][k]) % mod
    }
    return res
}