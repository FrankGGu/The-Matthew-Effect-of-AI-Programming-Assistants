package main

func maxScore(nums []int, kZero int) int {
    n := len(nums)
    dp := make([]int, n)
    dp[0] = nums[0]
    for i := 1; i < n; i++ {
        dp[i] = dp[i-1] + nums[i]
    }
    maxScore := 0
    for i := 0; i < n; i++ {
        if nums[i] == 0 {
            left := 0
            if i > 0 {
                left = dp[i-1]
            }
            right := 0
            if i < n-1 {
                right = dp[n-1] - dp[i]
            }
            currentScore := left + right
            if currentScore > maxScore {
                maxScore = currentScore
            }
        }
    }
    return maxScore
}