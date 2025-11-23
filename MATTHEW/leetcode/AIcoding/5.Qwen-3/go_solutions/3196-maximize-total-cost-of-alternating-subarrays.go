package main

func maxAlternatingSubarrays(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
        if i > 0 && nums[i] != nums[i-1] {
            dp[i] = dp[i-1] + 1
        }
    }
    maxVal := 0
    for _, v := range dp {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}