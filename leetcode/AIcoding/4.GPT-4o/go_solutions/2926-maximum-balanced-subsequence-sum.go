func maxBalancedSubsequenceSum(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    total := 0

    for i := 0; i < n; i++ {
        dp[i] = nums[i]
        for j := 0; j < i; j++ {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j]+nums[i])
            }
        }
        total = max(total, dp[i])
    }

    return total
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}