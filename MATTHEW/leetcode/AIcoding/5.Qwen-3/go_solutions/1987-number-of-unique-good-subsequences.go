package main

func numberOfUniqueGoodSubsequences(s string) int {
    mod := 1000000007
    hasZero := false
    dp := [2]int{0, 0}
    for _, c := range s {
        if c == '0' {
            hasZero = true
            dp[0] = (dp[0] + dp[1]) % mod
        } else {
            dp[1] = (dp[1] + dp[0] + 1) % mod
        }
    }
    return (dp[0] + dp[1]) % mod
}