func longestArithSeqLength(nums []int) int {
    n := len(nums)
    if n <= 2 {
        return n
    }
    dp := make([]map[int]int, n)
    for i := range dp {
        dp[i] = make(map[int]int)
    }
    maxLen := 2
    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            diff := nums[i] - nums[j]
            if val, ok := dp[j][diff]; ok {
                dp[i][diff] = val + 1
            } else {
                dp[i][diff] = 2
            }
            if dp[i][diff] > maxLen {
                maxLen = dp[i][diff]
            }
        }
    }
    return maxLen
}