func maxCoins(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    // Add 1 to both ends of the nums array
    balloons := make([]int, n+2)
    balloons[0] = 1
    balloons[n+1] = 1
    for i := 0; i < n; i++ {
        balloons[i+1] = nums[i]
    }

    dp := make([][]int, n+2)
    for i := range dp {
        dp[i] = make([]int, n+2)
    }

    for length := 1; length <= n; length++ {
        for left := 1; left <= n-length+1; left++ {
            right := left + length - 1
            for k := left; k <= right; k++ {
                dp[left][right] = max(dp[left][right], dp[left][k-1]+dp[k+1][right]+balloons[left-1]*balloons[k]*balloons[right+1])
            }
        }
    }

    return dp[1][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}