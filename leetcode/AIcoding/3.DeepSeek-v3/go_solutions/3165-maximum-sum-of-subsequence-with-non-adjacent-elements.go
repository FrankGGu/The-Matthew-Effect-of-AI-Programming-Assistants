func maximumSum(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    if len(nums) == 1 {
        return max(nums[0], 0)
    }
    dp := make([]int, len(nums))
    dp[0] = max(nums[0], 0)
    dp[1] = max(nums[1], dp[0])
    for i := 2; i < len(nums); i++ {
        dp[i] = max(dp[i-1], dp[i-2]+max(nums[i], 0))
    }
    return dp[len(nums)-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}