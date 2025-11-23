package main

func longestSubsequence(nums []int, x int) int {
    n := len(nums)
    dp := make([]int, n)
    maxLen := 1
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if abs(nums[i]-nums[j]) == x {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
        maxLen = max(maxLen, dp[i])
    }
    return maxLen
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}