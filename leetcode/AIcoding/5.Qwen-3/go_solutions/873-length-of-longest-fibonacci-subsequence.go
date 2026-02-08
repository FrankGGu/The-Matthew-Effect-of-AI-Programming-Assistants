package main

func lenLongestFibSubseq(nums []int) int {
    n := len(nums)
    dp := make(map[int]map[int]int)
    maxLen := 0
    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            prev := nums[i] - nums[j]
            if val, ok := dp[nums[j]][prev]; ok {
                dp[nums[i]][nums[j]] = val + 1
                if dp[nums[i]][nums[j]] > maxLen {
                    maxLen = dp[nums[i]][nums[j]]
                }
            } else {
                dp[nums[i]][nums[j]] = 2
            }
        }
    }
    return maxLen
}