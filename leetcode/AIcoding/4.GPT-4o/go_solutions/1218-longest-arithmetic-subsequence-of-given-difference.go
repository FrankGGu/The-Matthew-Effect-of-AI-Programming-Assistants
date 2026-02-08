func longestSubsequence(arr []int, difference int) int {
    dp := make(map[int]int)
    maxLength := 0

    for _, num := range arr {
        dp[num] = dp[num-difference] + 1
        if dp[num] > maxLength {
            maxLength = dp[num]
        }
    }

    return maxLength
}