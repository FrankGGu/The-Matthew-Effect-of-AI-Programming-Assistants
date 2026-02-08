package main

func maxLength(nums []int, x int) int {
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if nums[i] == nums[j] {
                dp[i+1][j+1] = dp[i][j] + 1
            } else {
                dp[i+1][j+1] = max(dp[i][j+1], dp[i+1][j])
            }
        }
    }
    return dp[n][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}