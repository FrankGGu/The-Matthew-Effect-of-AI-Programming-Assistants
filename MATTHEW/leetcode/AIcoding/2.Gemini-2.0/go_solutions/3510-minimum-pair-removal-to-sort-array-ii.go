func minimumPairRemoval(nums []int) int {
    n := len(nums)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            dp[i][j] = dp[i+1][j] + 1
            for k := i + 1; k <= j; k++ {
                if nums[i] <= nums[k] {
                    dp[i][j] = min(dp[i][j], dp[i+1][k-1] + dp[k+1][j])
                }
            }
        }
    }

    return dp[0][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}