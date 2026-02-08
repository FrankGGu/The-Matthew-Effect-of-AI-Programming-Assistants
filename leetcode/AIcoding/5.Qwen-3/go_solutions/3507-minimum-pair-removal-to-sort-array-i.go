package main

func minRemovalsToSort(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if nums[j] <= nums[i] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    maxLen := 0
    for _, v := range dp {
        maxLen = max(maxLen, v)
    }
    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}