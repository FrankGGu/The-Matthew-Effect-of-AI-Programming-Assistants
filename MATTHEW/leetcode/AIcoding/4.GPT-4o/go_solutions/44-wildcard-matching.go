func isMatch(s string, p string) bool {
    sLen, pLen := len(s), len(p)
    dp := make([][]bool, sLen+1)
    for i := range dp {
        dp[i] = make([]bool, pLen+1)
    }
    dp[0][0] = true

    for j := 1; j <= pLen; j++ {
        if p[j-1] == '*' {
            dp[0][j] = dp[0][j-1]
        }
    }

    for i := 1; i <= sLen; i++ {
        for j := 1; j <= pLen; j++ {
            if p[j-1] == s[i-1] || p[j-1] == '?' {
                dp[i][j] = dp[i-1][j-1]
            } else if p[j-1] == '*' {
                dp[i][j] = dp[i-1][j] || dp[i][j-1]
            }
        }
    }

    return dp[sLen][pLen]
}