func maxMultiplicationScore(nums []int, multipliers []int) int {
    n, m := len(nums), len(multipliers)
    dp := make([]int, m+1)

    for i := 0; i < m; i++ {
        for j := i; j >= 0; j-- {
            left := dp[j] + multipliers[i]*nums[j]
            right := dp[j-1] + multipliers[i]*nums[n-1-(i-j)]
            if j > 0 {
                dp[j] = max(left, right)
            } else {
                dp[j] = right
            }
        }
    }

    maxScore := dp[0]
    for i := 1; i <= m; i++ {
        maxScore = max(maxScore, dp[i])
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}