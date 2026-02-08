func longestIdealString(s string, k int) int {
    dp := make([]int, 128)
    maxLength := 0

    for _, ch := range s {
        currentChar := int(ch)
        minChar := max(0, currentChar-k)
        maxChar := min(127, currentChar+k)

        maxSubsequenceLength := 0
        for j := minChar; j <= maxChar; j++ {
            maxSubsequenceLength = max(maxSubsequenceLength, dp[j])
        }

        dp[currentChar] = max(dp[currentChar], maxSubsequenceLength + 1)
        maxLength = max(maxLength, dp[currentChar])
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}