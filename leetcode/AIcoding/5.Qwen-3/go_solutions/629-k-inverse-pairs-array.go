package main

func kInversePairs(n int, k int) int {
    MOD := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = (dp[i-1][j] + (dp[i][j-1] if j > 0 else 0)) % MOD
            if j >= i {
                dp[i][j] = (dp[i][j] - dp[i-1][j-i] + MOD) % MOD
            }
        }
    }
    return dp[n][k]
}