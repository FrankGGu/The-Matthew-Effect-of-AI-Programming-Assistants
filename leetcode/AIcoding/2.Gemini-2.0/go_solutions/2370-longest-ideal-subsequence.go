func longestIdealString(s string, k int) int {
    dp := make([]int, 26)
    for _, char := range s {
        idx := int(char - 'a')
        maxLen := 0
        for i := 0; i < 26; i++ {
            if abs(idx - i) <= k {
                if dp[i] > maxLen {
                    maxLen = dp[i]
                }
            }
        }
        dp[idx] = maxLen + 1
    }
    maxLen := 0
    for _, len := range dp {
        if len > maxLen {
            maxLen = len
        }
    }
    return maxLen
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}