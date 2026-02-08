func maximumStrength(nums []int, k int) int64 {
    n := len(nums)
    dp := make([][]int64, n+1)
    for i := range dp {
        dp[i] = make([]int64, k+1)
        for j := range dp[i] {
            dp[i][j] = -1e18
        }
    }
    dp[0][0] = 0

    for j := 1; j <= k; j++ {
        var sign int64
        if j%2 == 1 {
            sign = 1
        } else {
            sign = -1
        }
        strength := sign * int64(k-j+1)
        maxPrev := -1e18
        for i := 1; i <= n; i++ {
            maxPrev = max(maxPrev, dp[i-1][j-1])
            dp[i][j] = max(dp[i-1][j]+int64(nums[i-1])*strength, maxPrev+int64(nums[i-1])*strength)
        }
    }

    res := -1e18
    for i := 1; i <= n; i++ {
        res = max(res, dp[i][k])
    }
    return res
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}