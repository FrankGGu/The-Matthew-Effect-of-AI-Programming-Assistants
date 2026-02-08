func deleteString(s string) int {
    n := len(s)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = 1
    }

    for i := n - 1; i >= 0; i-- {
        for l := 1; i + 2 * l <= n; l++ {
            if s[i:i+l] == s[i+l:i+2*l] {
                if dp[i] < 1 + dp[i+l] {
                    dp[i] = 1 + dp[i+l]
                }
            }
        }
    }

    return dp[0]
}