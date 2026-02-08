package main

func minIncrementOperationsToMakeArrayBeautiful(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        dp[i] = nums[i]
        for j := i + 1; j <= i+2 && j < n; j++ {
            dp[i] = max(dp[i], nums[i]+dp[j])
        }
    }
    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}