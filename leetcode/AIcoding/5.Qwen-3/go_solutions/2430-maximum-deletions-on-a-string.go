package main

func maxDeletions(s string) int {
    dp := make([]int, 26)
    for _, c := range s {
        idx := int(c - 'a')
        dp[idx] = 1
        for i := 0; i < 26; i++ {
            if i != idx && dp[i] > 0 {
                dp[idx] = max(dp[idx], dp[i]+1)
            }
        }
    }
    maxVal := 0
    for _, v := range dp {
        maxVal = max(maxVal, v)
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}