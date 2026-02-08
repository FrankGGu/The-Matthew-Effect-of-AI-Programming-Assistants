package main

func maxArrayValue(nums []int, k int) int {
    n := len(nums)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 0; i < n; i++ {
        dp[i][0] = nums[i]
    }

    for i := 1; i < n; i++ {
        for j := 1; j <= k; j++ {
            dp[i][j] = -1
            for m := 0; m < i; m++ {
                if dp[m][j-1] != -1 && nums[i] >= dp[m][j-1] {
                    dp[i][j] = max(dp[i][j], dp[m][j-1]+nums[i])
                }
            }
        }
    }

    result := -1
    for i := 0; i < n; i++ {
        result = max(result, dp[i][k])
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}