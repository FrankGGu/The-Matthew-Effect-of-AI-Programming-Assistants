package main

func sortGroups(nums []int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := 0; i < n; i++ {
        dp[i+1] = dp[i] + 1
        for j := 0; j < i; j++ {
            if nums[j] <= nums[i] {
                dp[i+1] = min(dp[i+1], dp[j]+1)
            }
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}