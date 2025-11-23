func maximumTotalCost(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([][2]int64, n)
    dp[0][0] = int64(nums[0])
    dp[0][1] = int64(nums[0])

    for i := 1; i < n; i++ {
        dp[i][0] = max(dp[i-1][0] + int64(nums[i]), dp[i-1][1] - int64(nums[i]))
        dp[i][1] = max(dp[i-1][0] - int64(nums[i]), dp[i-1][1] + int64(nums[i]))
    }

    return max(dp[n-1][0], dp[n-1][1])
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}