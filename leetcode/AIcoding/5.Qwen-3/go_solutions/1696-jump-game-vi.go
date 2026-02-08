package main

func maxSumAfterJump(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    dp[0] = nums[0]
    for i := 1; i < n; i++ {
        maxVal := dp[i-1]
        for j := i - 1; j >= 0 && i-j <= k; j-- {
            if dp[j]+nums[i] > maxVal {
                maxVal = dp[j] + nums[i]
            }
        }
        dp[i] = maxVal
    }
    return dp[n-1]
}