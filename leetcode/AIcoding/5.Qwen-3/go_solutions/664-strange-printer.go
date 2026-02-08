package main

func strangePrinter(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := n - 1; i >= 0; i-- {
        dp[i][i] = 1
        for j := i + 1; j < n; j++ {
            dp[i][j] = dp[i][j-1]
            if s[j] == s[j-1] {
                dp[i][j]--
            } else {
                for k := i; k < j; k++ {
                    dp[i][j] = min(dp[i][j], dp[i][k]+dp[k+1][j])
                }
            }
        }
    }
    return dp[0][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}