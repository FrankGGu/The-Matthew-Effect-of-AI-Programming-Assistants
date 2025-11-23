package main

func countDifferentPalindromicSubsequences(s string) int {
    n := len(s)
    mod := 1000000007
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        dp[i][i] = 1
    }
    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                dp[i][j] = dp[i+1][j-1]*2
                if i+1 <= j-1 {
                    if s[i+1] == s[j-1] {
                        dp[i][j] += 2
                    } else {
                        dp[i][j] += 0
                    }
                }
                if i+1 <= j-1 {
                    dp[i][j] += dp[i+1][j-1]
                }
            } else {
                dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]
            }
            if dp[i][j] < 0 {
                dp[i][j] += mod
            }
            dp[i][j] %= mod
        }
    }
    return dp[0][n-1]
}