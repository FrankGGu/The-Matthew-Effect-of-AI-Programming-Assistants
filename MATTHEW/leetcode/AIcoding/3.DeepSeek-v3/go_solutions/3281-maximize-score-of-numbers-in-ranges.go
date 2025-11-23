func maxScore(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }

    for i := m-1; i >= 0; i-- {
        for left := i; left >= 0; left-- {
            right := n - 1 - (i - left)
            dp[i][left] = max(
                multipliers[i]*nums[left] + dp[i+1][left+1],
                multipliers[i]*nums[right] + dp[i+1][left],
            )
        }
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}