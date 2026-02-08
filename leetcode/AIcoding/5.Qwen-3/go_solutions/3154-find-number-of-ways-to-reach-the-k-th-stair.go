package main

func waysToReachKthStair(_ int, k int) int {
    if k == 0 {
        return 1
    }
    dp := make([]int, k+1)
    dp[0] = 1
    for i := 1; i <= k; i++ {
        dp[i] = dp[i-1]
        if i >= 2 {
            dp[i] += dp[i-2]
        }
    }
    return dp[k]
}