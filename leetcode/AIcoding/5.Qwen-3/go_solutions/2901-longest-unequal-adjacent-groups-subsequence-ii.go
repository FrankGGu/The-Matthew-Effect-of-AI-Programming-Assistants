package main

func getLengthOfOptimalSubsequence(s string, t string) int {
    n := len(s)
    m := len(t)
    dp := make([]int, m+1)
    for i := 0; i < n; i++ {
        for j := m - 1; j >= 0; j-- {
            if s[i] == t[j] {
                dp[j+1] = max(dp[j+1], dp[j]+1)
            }
        }
    }
    return dp[m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}