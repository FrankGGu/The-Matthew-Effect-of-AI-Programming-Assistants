func maxScore(nums []int) int {
    n := len(nums)
    dp := make([]int, n+1)

    for i := 0; i < n; i++ {
        for j := i + 1; j < n+1; j++ {
            dp[j] = max(dp[j], dp[j-1]+nums[i])
        }
    }

    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}