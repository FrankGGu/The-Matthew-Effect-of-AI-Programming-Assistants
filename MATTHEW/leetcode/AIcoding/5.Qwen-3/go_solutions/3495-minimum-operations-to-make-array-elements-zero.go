package main

func minimumOperations(nums []int, x int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            dp[i] = 0
        } else {
            dp[i] = 1
        }
    }
    for i := 1; i < n; i++ {
        if nums[i] != 0 {
            dp[i] = min(dp[i-1]+1, dp[i])
        }
    }
    for i := n - 2; i >= 0; i-- {
        if nums[i] != 0 {
            dp[i] = min(dp[i+1]+1, dp[i])
        }
    }
    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}