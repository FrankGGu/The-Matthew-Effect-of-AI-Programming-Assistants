package main

func minCost(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1 << 63
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        if i > 0 {
            dp[i] = min(dp[i], dp[i-1]+1)
        }
        for j := i + 1; j < n && j-i < k; j++ {
            if arr[j] == arr[i] {
                dp[j] = min(dp[j], dp[i])
            } else {
                dp[j] = min(dp[j], dp[i]+1)
            }
        }
    }
    return dp[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}