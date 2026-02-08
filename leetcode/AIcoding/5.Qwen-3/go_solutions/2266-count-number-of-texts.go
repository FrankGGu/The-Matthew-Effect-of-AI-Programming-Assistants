package main

func countTexts(s string) int {
    mod := int(1e9 + 7)
    dp := make([]int, len(s)+1)
    dp[0] = 1
    for i := 0; i < len(s); i++ {
        if i > 0 && s[i] == s[i-1] {
            dp[i+1] = (dp[i+1] + dp[i-1]) % mod
        }
        dp[i+1] = (dp[i+1] + dp[i]) % mod
        if i+2 < len(s) && s[i] == s[i+1] && s[i] == s[i+2] {
            dp[i+3] = (dp[i+3] + dp[i]) % mod
        }
        if i+3 < len(s) && s[i] == s[i+1] && s[i] == s[i+2] && s[i] == s[i+3] {
            dp[i+4] = (dp[i+4] + dp[i]) % mod
        }
    }
    return dp[len(s)]
}