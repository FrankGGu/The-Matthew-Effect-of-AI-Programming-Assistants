func minimumScore(s string, t string) int {
    n, m := len(s), len(t)
    dp := make([]int, m+1)

    for i := 1; i <= n; i++ {
        for j := m; j > 0; j-- {
            if s[i-1] == t[j-1] {
                dp[j] = max(dp[j], dp[j-1]+1)
            }
        }
    }

    maxMatch := dp[m]
    minScore := m - maxMatch
    return minScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}