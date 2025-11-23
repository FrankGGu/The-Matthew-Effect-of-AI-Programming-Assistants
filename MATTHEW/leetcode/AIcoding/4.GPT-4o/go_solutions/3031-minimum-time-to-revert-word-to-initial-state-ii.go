func minimumTime(words []string) int {
    n := len(words)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = len(words[i])
    }

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if words[i] == words[j] {
                dp[i] = min(dp[i], dp[j]+len(words[i]))
            }
        }
    }

    result := 0
    for _, time := range dp {
        result += time
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}