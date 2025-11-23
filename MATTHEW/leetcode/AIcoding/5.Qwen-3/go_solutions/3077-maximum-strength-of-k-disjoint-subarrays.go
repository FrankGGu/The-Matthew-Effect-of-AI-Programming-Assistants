package main

func maxSumAfterKDisjointSubarrays(nums []int, k int) int {
    n := len(nums)
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < k; i++ {
        for j := 0; j < n; j++ {
            if i == 0 {
                dp[i][j] = max(dp[i][j-1], nums[j])
            } else {
                dp[i][j] = dp[i][j-1]
                if j > 0 {
                    dp[i][j] = max(dp[i][j], dp[i-1][j-1]+nums[j])
                }
            }
        }
    }

    return dp[k][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}