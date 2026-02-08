func distinctSubseqII(s string) int {
    mod := int(1e9 + 7)
    last := [26]int{}
    dp := make([]int, len(s)+1)
    dp[0] = 1

    for i := 1; i <= len(s); i++ {
        dp[i] = (2*dp[i-1]) % mod
        dp[i] = (dp[i] - last[s[i-1]-'a'] + mod) % mod
        last[s[i-1]-'a'] = dp[i-1]
    }

    return (dp[len(s)] - 1 + mod) % mod
}