package main

func lengthOfLongestSubsequence(nums []int, target int) int {
    dp := make([]int, target+1)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0
    for _, num := range nums {
        for j := target; j >= num; j-- {
            if dp[j-num] != -1 {
                dp[j] = max(dp[j], dp[j-num]+1)
            }
        }
    }
    return dp[target]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}