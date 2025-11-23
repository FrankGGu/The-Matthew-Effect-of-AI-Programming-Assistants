package main

func minDeletions(s string) int {
    n := len(s)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if s[i] != s[j] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    maxLen := 0
    for _, v := range dp {
        maxLen = max(maxLen, v)
    }
    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}