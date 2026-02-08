package main

func distinctSubseq(a string) int {
    mod := 1000000007
    dp := make([]int, len(a)+1)
    dp[0] = 1
    last := make(map[byte]int)
    for i := 1; i <= len(a); i++ {
        dp[i] = (dp[i-1] * 2) % mod
        if j, ok := last[a[i-1]]; ok {
            dp[i] = (dp[i] - dp[j-1] + mod) % mod
        }
        last[a[i-1]] = i
    }
    return dp[len(a)] - 1
}