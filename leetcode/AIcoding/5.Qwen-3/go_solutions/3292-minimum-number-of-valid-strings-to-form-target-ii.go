package main

func minValidStrings(words []string, target string) int {
    n := len(target)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = n + 1
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        if dp[i] == n+1 {
            continue
        }
        for _, word := range words {
            j := 0
            k := i
            for k < n && j < len(word) && target[k] == word[j] {
                j++
                k++
            }
            if j > 0 {
                dp[k] = min(dp[k], dp[i]+1)
            }
        }
    }
    if dp[n] == n+1 {
        return -1
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}