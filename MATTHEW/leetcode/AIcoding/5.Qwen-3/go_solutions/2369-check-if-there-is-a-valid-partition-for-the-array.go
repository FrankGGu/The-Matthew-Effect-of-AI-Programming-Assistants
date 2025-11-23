package main

func validPartition(nums []int) bool {
    n := len(nums)
    dp := make([]bool, n+1)
    dp[0] = true

    for i := 1; i <= n; i++ {
        if i >= 3 && dp[i-3] && nums[i-1] == nums[i-2] && nums[i-2] == nums[i-3] {
            dp[i] = true
        } else if i >= 2 && dp[i-2] && nums[i-1] == nums[i-2] {
            dp[i] = true
        } else if i >= 3 && dp[i-3] && nums[i-1] == nums[i-2]+1 && nums[i-2] == nums[i-3]+1 {
            dp[i] = true
        }
    }

    return dp[n]
}