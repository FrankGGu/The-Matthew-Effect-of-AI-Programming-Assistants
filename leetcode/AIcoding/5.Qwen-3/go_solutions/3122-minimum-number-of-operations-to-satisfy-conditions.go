package main

func minOperations(nums []int) int {
    n := len(nums)
    dp := make([][2]int, n)
    dp[0][0] = 0
    dp[0][1] = 1

    for i := 1; i < n; i++ {
        if nums[i] != nums[i-1] {
            dp[i][0] = dp[i-1][1]
            dp[i][1] = dp[i-1][0] + 1
        } else {
            dp[i][0] = dp[i-1][0]
            dp[i][1] = dp[i-1][1] + 1
        }
    }

    return min(dp[n-1][0], dp[n-1][1])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}