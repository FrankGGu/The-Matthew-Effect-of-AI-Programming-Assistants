func longestIdealString(s string, k int) int {
    dp := make([]int, 26)
    maxLen := 0

    for _, c := range s {
        current := int(c - 'a')
        max := 0
        start := max(0, current - k)
        end := min(25, current + k)

        for i := start; i <= end; i++ {
            if dp[i] > max {
                max = dp[i]
            }
        }

        dp[current] = max + 1
        if dp[current] > maxLen {
            maxLen = dp[current]
        }
    }

    return maxLen
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