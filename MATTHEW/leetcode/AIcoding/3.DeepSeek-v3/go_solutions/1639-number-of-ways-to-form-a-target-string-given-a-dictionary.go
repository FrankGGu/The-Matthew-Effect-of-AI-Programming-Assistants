func numWays(words []string, target string) int {
    const mod = 1e9 + 7
    n := len(words[0])
    m := len(target)
    cnt := make([][]int, n)
    for i := range cnt {
        cnt[i] = make([]int, 26)
    }
    for _, word := range words {
        for i, c := range word {
            cnt[i][c-'a']++
        }
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    dp[0][0] = 1
    for i := 0; i < n; i++ {
        for j := 0; j <= m; j++ {
            if j < m {
                dp[i+1][j+1] = (dp[i+1][j+1] + dp[i][j]*cnt[i][target[j]-'a']) % mod
            }
            dp[i+1][j] = (dp[i+1][j] + dp[i][j]) % mod
        }
    }
    return dp[n][m]
}