func distinctSubseqII(s string) int {
    const mod = 1e9 + 7
    dp := make([]int, len(s)+1)
    dp[0] = 1
    last := make(map[byte]int)

    for i := 1; i <= len(s); i++ {
        dp[i] = dp[i-1] * 2 % mod
        if pos, exists := last[s[i-1]]; exists {
            dp[i] = (dp[i] - dp[pos-1] + mod) % mod
        }
        last[s[i-1]] = i
    }

    return (dp[len(s)] - 1) % mod
}