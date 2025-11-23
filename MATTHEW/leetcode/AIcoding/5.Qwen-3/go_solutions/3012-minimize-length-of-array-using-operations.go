package main

func minArrayLength(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if nums[i]%k == nums[j]%k {
                dp[i] = min(dp[i], dp[j]+1)
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