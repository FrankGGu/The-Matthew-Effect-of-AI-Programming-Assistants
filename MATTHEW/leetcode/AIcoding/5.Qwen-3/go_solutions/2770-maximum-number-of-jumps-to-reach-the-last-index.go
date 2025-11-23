package main

func maximumJumps(nums []int, cost []int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        if dp[i] == -1 {
            continue
        }
        for j := i + 1; j < n; j++ {
            if nums[j] > nums[i] {
                dp[j] = max(dp[j], dp[i]+cost[i])
            }
        }
    }
    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}