package main

func findMaximumLength(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    prev := make([]int, n)
    for i := range dp {
        dp[i] = 1
        prev[i] = -1
    }

    maxLen := 1
    endIndex := 0

    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if nums[j] < nums[i] && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
                prev[i] = j
            }
        }
        if dp[i] > maxLen {
            maxLen = dp[i]
            endIndex = i
        }
    }

    return maxLen
}