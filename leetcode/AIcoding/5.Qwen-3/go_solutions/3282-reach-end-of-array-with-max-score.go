package main

func maxScore(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, n)
    dp[0] = arr[0]
    for i := 1; i < n; i++ {
        dp[i] = dp[i-1] + arr[i]
    }
    for i := 1; i < k; i++ {
        dp[i] = max(dp[i], dp[i-1])
    }
    for i := k; i < n; i++ {
        dp[i] = max(dp[i], dp[i-1])
    }
    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}