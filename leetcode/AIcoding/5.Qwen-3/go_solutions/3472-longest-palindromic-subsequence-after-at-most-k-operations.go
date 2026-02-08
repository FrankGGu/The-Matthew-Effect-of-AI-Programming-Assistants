package main

func longestPalindrome(s string, k int) int {
    n := len(s)
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
                if length == 2 {
                    dp[i][j] = 2
                } else {
                    dp[i][j] = dp[i+1][j-1] + 2
                }
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j-1])
            }
        }
    }

    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}