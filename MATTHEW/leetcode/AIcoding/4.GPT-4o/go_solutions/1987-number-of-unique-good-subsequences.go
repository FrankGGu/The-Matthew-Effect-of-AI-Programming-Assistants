func countGoodSubsequences(binary string) int {
    mod := int(1e9 + 7)
    last := -1
    n := len(binary)
    count := 0
    dp := make([]int, n+1)
    dp[0] = 1

    for i := 0; i < n; i++ {
        if binary[i] == '1' {
            count++
            last = i
        }
        dp[i+1] = (dp[i] * 2) % mod
        if last >= 0 {
            dp[i+1] = (dp[i+1] - dp[last]) % mod
        }
    }

    return (dp[n] + mod) % mod
}