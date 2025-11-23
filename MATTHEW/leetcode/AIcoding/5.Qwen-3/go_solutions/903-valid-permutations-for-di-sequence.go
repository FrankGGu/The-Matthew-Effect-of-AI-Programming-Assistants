package main

func numPermutations(s string) int {
    mod := 1000000007
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        for j := 0; j <= i; j++ {
            if s[i-1] == 'D' {
                for k := 0; k < j; k++ {
                    dp[i][j] += dp[i-1][k]
                    dp[i][j] %= mod
                }
            } else {
                for k := j; k < i; k++ {
                    dp[i][j] += dp[i-1][k]
                    dp[i][j] %= mod
                }
            }
        }
    }
    result := 0
    for j := 0; j <= n; j++ {
        result += dp[n][j]
        result %= mod
    }
    return result
}