package main

func numberOfCopyArrays(nums []int) int {
    mod := 1000000007
    n := len(nums)
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        if nums[i-1] == 0 {
            dp[i] = dp[i-1]
        } else {
            dp[i] = (dp[i-1] * nums[i-1]) % mod
        }
    }
    return dp[n]
}