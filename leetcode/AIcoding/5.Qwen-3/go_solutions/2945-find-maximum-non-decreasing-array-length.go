package main

func findMaximumNonDecreasingArrayLength(arr []int) int {
    n := len(arr)
    if n == 0 {
        return 0
    }
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if arr[j] <= arr[i] && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
    }
    maxLen := 0
    for i := 0; i < n; i++ {
        if dp[i] > maxLen {
            maxLen = dp[i]
        }
    }
    return maxLen
}