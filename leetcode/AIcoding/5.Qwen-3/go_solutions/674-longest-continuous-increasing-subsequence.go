package main

func lengthOfLIS(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    dp := make([]int, len(nums))
    for i := range dp {
        dp[i] = 1
    }
    for i := 1; i < len(nums); i++ {
        for j := 0; j < i; j++ {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    maxLen := 0
    for _, v := range dp {
        if v > maxLen {
            maxLen = v
        }
    }
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}