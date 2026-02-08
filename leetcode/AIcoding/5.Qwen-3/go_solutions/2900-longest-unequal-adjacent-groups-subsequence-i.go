package main

func getSubsequence(s string, k int) string {
    n := len(s)
    dp := make([]int, n)
    prev := make([]int, n)
    for i := range dp {
        dp[i] = 1
        prev[i] = -1
    }
    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if s[j] != s[i] && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
                prev[i] = j
            }
        }
    }
    maxLen := 0
    idx := 0
    for i := range dp {
        if dp[i] > maxLen {
            maxLen = dp[i]
            idx = i
        }
    }
    result := make([]byte, 0, maxLen)
    for idx != -1 {
        result = append(result, s[idx])
        idx = prev[idx]
    }
    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }
    return string(result)
}