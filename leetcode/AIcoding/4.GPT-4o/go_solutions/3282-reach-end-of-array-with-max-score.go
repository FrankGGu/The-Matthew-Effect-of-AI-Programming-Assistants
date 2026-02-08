func maxScore(nums []int) int64 {
    n := len(nums)
    dp := make([]int64, n+1)
    for i := 0; i < n; i++ {
        dp[i+1] = dp[i] + int64(nums[i])
    }
    maxScore := int64(0)
    for i := 1; i <= n; i++ {
        maxScore = max(maxScore, dp[i])
    }
    return maxScore
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}