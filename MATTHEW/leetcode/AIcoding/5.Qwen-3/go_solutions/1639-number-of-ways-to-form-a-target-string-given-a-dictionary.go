package main

func numWays(words []string, target string) int {
    mod := 1000000007
    n := len(target)
    m := len(words[0])
    cnt := make([][]int, len(words))
    for i := range cnt {
        cnt[i] = make([]int, 26)
    }
    for _, word := range words {
        for j, c := range word {
            cnt[j][c-'a']++
        }
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 0; i <= m; i++ {
        dp[0][i] = 1
    }
    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            dp[i][j] = (dp[i][j-1] + dp[i-1][j-1]*cnt[j-1][target[i-1]-'a']) % mod
        }
    }
    return dp[n][m]
}