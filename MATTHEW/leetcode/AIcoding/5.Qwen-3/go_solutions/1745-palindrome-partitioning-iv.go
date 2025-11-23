package main

func checkPartitioning(s string) bool {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }
    for i := 0; i < n; i++ {
        dp[i][i] = true
    }
    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                if length == 2 {
                    dp[i][j] = true
                } else {
                    dp[i][j] = dp[i+1][j-1]
                }
            }
        }
    }
    for i := 1; i < n-1; i++ {
        if dp[0][i] && dp[i+1][n-1] {
            return true
        }
    }
    return false
}