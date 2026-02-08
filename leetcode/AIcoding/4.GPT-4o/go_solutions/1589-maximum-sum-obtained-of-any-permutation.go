func maxSum(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)
    dp := make([]int, m+1)

    for i := 1; i <= m; i++ {
        dp[i] = -1 << 31
    }

    for i := m - 1; i >= 0; i-- {
        for j := 0; j <= i; j++ {
            dp[j] = max(dp[j], dp[j+1]+nums[i+j]*multipliers[i])
        }
    }

    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}