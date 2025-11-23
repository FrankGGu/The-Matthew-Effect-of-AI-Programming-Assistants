package main

func longestSubsequence(nums []int, difference int) int {
    dp := make(map[int]int)
    maxLen := 0
    for _, num := range nums {
        prev := num - difference
        dp[num] = dp[prev] + 1
        if dp[num] > maxLen {
            maxLen = dp[num]
        }
    }
    return maxLen
}