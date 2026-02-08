package main

func canReachEnd(arr []int, jumpLen int) bool {
    n := len(arr)
    dp := make([]bool, n)
    dp[0] = true
    for i := 0; i < n; i++ {
        if dp[i] {
            for j := i + 1; j < n && j <= i+jumpLen; j++ {
                if arr[j] >= arr[i] {
                    dp[j] = true
                }
            }
        }
    }
    return dp[n-1]
}