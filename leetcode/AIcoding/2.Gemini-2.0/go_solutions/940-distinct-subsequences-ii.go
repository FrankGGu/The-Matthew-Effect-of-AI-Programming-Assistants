func distinctSubseqII(s string) int {
    n := len(s)
    dp := make([]int, 26)
    mod := 1000000007
    sum := 0
    for i := 0; i < n; i++ {
        idx := int(s[i] - 'a')
        prev := dp[idx]
        dp[idx] = (sum + 1) % mod
        sum = (sum + dp[idx] - prev + mod) % mod
    }
    return sum
}