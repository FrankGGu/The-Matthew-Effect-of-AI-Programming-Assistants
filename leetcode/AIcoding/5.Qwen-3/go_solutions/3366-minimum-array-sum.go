package main

func minArraySum(nums []int, k int, x int) int {
    MOD := int(1e9 + 7)
    n := len(nums)
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        dp[0][i] = nums[i]
    }
    for step := 1; step <= k; step++ {
        for i := 0; i < n; i++ {
            if i == 0 {
                dp[step][i] = dp[step-1][i]
            } else {
                dp[step][i] = (dp[step-1][i] + dp[step][i-1]) % MOD
            }
        }
    }
    return dp[k][n-1]
}