func numDecodings(s string) int {
    const mod = 1e9 + 7
    n := len(s)
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        if s[i-1] == '*' {
            dp[i] = (dp[i] + 9*dp[i-1]) % mod
        } else if s[i-1] != '0' {
            dp[i] = (dp[i] + dp[i-1]) % mod
        }
        if i >= 2 {
            if s[i-2] == '*' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + 15*dp[i-2]) % mod
                } else if s[i-1] <= '6' {
                    dp[i] = (dp[i] + 2*dp[i-2]) % mod
                } else {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            } else if s[i-2] == '1' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + 9*dp[i-2]) % mod
                } else {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            } else if s[i-2] == '2' {
                if s[i-1] == '*' {
                    dp[i] = (dp[i] + 6*dp[i-2]) % mod
                } else if s[i-1] <= '6' {
                    dp[i] = (dp[i] + dp[i-2]) % mod
                }
            }
        }
    }
    return dp[n]
}