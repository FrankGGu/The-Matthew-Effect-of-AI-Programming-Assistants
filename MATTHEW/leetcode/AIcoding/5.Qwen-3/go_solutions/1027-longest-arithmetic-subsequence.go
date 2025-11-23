package main

func longestArithSeqSubseq(nums []int, l int) int {
    if l < 2 {
        return l
    }
    dp := make([]map[int]int, l)
    for i := range dp {
        dp[i] = make(map[int]int)
    }
    maxLen := 2
    for i := 0; i < l; i++ {
        for j := 0; j < i; j++ {
            diff := nums[i] - nums[j]
            dp[i][diff] = dp[j][diff] + 1
            if dp[i][diff] > maxLen {
                maxLen = dp[i][diff]
            }
        }
    }
    return maxLen
}