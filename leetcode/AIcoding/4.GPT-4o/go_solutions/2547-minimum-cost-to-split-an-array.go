func minCost(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + nums[i-1]
    }

    for j := 1; j <= k; j++ {
        newDp := make([]int, n+1)
        for i := 1; i <= n; i++ {
            newDp[i] = math.MaxInt32
            sum := 0
            for l := i; l > 0; l-- {
                sum += nums[l-1]
                newDp[i] = min(newDp[i], newDp[l-1]+sum)
            }
        }
        dp = newDp
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}