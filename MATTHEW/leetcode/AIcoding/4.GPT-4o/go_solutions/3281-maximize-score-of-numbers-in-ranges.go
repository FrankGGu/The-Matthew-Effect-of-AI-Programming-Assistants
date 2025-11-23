package main

import "sort"

func maximizeScore(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)
    dp := make([]int, m+1)

    for i := 1; i <= m; i++ {
        dp[i] = dp[i-1] + multipliers[i-1]*nums[i-1]
    }

    for i := 1; i <= m; i++ {
        for j := 0; j < i; j++ {
            dp[i] = max(dp[i], dp[j]+ multipliers[i-1]*nums[n-1-(i-j)])
        }
    }

    return dp[m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}