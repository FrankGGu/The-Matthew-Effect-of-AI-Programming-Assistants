func longestSubsequence(arr []int, target int) int {
    dp := make(map[int]int)
    dp[0] = 0
    maxLength := 0

    for _, num := range arr {
        for sum := target; sum >= num; sum-- {
            if _, exists := dp[sum-num]; exists {
                dp[sum] = max(dp[sum], dp[sum-num]+1)
                maxLength = max(maxLength, dp[sum])
            }
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}