func minDeletionSize(strs []string) int {
    n := len(strs)
    m := len(strs[0])
    dp := make([]int, m)
    for i := range dp {
        dp[i] = 1
    }

    for i := 1; i < m; i++ {
        for j := 0; j < i; j++ {
            sorted := true
            for k := 0; k < n; k++ {
                if strs[k][j] > strs[k][i] {
                    sorted = false
                    break
                }
            }
            if sorted {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }

    maxLen := 0
    for _, val := range dp {
        maxLen = max(maxLen, val)
    }

    return m - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}