package main

func numMusicPlaylists(n int, goal int, k int) int {
    MOD := int(1e9 + 7)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, goal+1)
    }
    dp[0][0] = 1
    for i := 0; i < n; i++ {
        for j := 0; j <= goal; j++ {
            if dp[i][j] == 0 {
                continue
            }
            if j+1 <= goal {
                dp[i+1][j+1] = (dp[i+1][j+1] + dp[i][j]*(n-i)) % MOD
            }
            if j+k <= goal {
                dp[i][j+k] = (dp[i][j+k] + dp[i][j]) % MOD
            }
        }
    }
    return dp[n][goal]
}