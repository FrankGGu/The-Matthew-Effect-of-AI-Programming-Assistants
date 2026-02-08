package main

func maxProductSubsequence(nums []int, k int) int {
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 0; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = -1
        }
    }
    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = dp[i-1][j]
            if j >= nums[i-1] {
                if dp[i-1][j-nums[i-1]] != -1 {
                    dp[i][j] = max(dp[i][j], dp[i-1][j-nums[i-1]]*nums[i-1])
                }
            }
        }
    }
    return dp[n][k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}