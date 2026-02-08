package main

func minOperations(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 0; i < k; i++ {
        sub := make([]int, 0)
        for j := i; j < n; j += k {
            sub = append(sub, nums[j])
        }
        res += lis(sub)
    }
    return res
}

func lis(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    maxLen := 0
    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if nums[j] <= nums[i] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
        maxLen = max(maxLen, dp[i])
    }
    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}