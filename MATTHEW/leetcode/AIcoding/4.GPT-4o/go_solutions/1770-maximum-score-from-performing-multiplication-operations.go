func maximumScore(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)
    dp := make([]int, m+1)

    for i := m - 1; i >= 0; i-- {
        for j := 0; j <= i; j++ {
            left := dp[j] + multipliers[i]*nums[j]
            right := dp[j+1] + multipliers[i]*nums[n-1-(i-j)]
            dp[j] = max(left, right)
        }
    }
    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}