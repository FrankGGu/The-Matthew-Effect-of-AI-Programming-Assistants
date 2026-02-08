func minExtraChar(s string, dictionary []string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + 1
        for _, word := range dictionary {
            m := len(word)
            if i >= m && s[i-m:i] == word {
                if dp[i-m] < dp[i] {
                    dp[i] = dp[i-m]
                }
            }
        }
    }
    return dp[n]
}