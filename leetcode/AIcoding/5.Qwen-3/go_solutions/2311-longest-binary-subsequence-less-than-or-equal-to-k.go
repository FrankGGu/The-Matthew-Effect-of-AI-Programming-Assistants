package main

func longestBinarySubsequence(s string, k int) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 0; i < n; i++ {
        dp[i+1] = dp[i]
        if s[i] == '0' {
            dp[i+1]++
        } else {
            if i >= 0 && (i+1) <= 30 {
                val := 0
                for j := i; j >= 0 && j >= i-29; j-- {
                    val = val*2 + int(s[j]-'0')
                    if val <= k {
                        dp[i+1] = max(dp[j], dp[i+1])
                    }
                }
            }
        }
    }
    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}