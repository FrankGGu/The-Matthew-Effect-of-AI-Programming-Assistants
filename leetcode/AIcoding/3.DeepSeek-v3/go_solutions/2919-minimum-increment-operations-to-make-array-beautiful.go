func minIncrementOperations(nums []int, k int) int64 {
    n := len(nums)
    dp := make([]int64, n)
    for i := 0; i < n; i++ {
        if i < 3 {
            dp[i] = max(0, int64(k - nums[i]))
        } else {
            dp[i] = max(0, int64(k - nums[i])) + min(dp[i-1], min(dp[i-2], dp[i-3]))
        }
    }
    if n < 3 {
        return 0
    }
    return min(dp[n-1], min(dp[n-2], dp[n-3]))
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}