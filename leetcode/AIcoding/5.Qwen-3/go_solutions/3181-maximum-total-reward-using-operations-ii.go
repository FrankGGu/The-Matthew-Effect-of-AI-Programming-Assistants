package main

func maxTotalReward(arr []int, k int) int {
    sort.Ints(arr)
    n := len(arr)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = arr[i]
    }
    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if arr[i]-arr[j] > k {
                break
            }
            dp[i] = max(dp[i], dp[j]+arr[i])
        }
    }
    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}