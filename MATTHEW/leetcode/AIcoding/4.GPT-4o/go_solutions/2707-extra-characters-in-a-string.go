func countExtraCharacters(s string, dictionary []string) int {
    dictSet := make(map[string]struct{})
    for _, word := range dictionary {
        dictSet[word] = struct{}{}
    }

    n := len(s)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + 1
        for j := 0; j < i; j++ {
            if _, exists := dictSet[s[j:i]]; exists {
                dp[i] = min(dp[i], dp[j])
            }
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}