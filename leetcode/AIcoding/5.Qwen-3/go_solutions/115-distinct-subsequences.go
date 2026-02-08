package main

func countDistinctSubseqA(s string) int {
    mod := 1000000007
    n := len(s)
    dp := make([]int, n+1)
    dp[0] = 1
    last := make(map[byte]int)
    for i := 1; i <= n; i++ {
        dp[i] = (dp[i-1] * 2) % mod
        if j, ok := last[s[i-1]]; ok {
            dp[i] = (dp[i] - dp[j-1] + mod) % mod
        }
        last[s[i-1]] = i
    }
    return dp[n] - 1
}