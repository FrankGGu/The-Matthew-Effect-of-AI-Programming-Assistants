package main

func numDecodings(s string) int {
    mod := 1000000007
    n := len(s)
    dp := make([]int, n+1)
    dp[0] = 1
    if s[0] == '0' {
        return 0
    }
    dp[1] = 1
    for i := 2; i <= n; i++ {
        one := s[i-1]
        two := s[i-2]
        if one == '0' {
            dp[i] = 0
        } else {
            dp[i] += dp[i-1]
        }
        if two == '1' || (two == '2' && one <= '6') {
            dp[i] += dp[i-2]
        } else if two == '0' {
            dp[i] = 0
        }
        dp[i] %= mod
    }
    return dp[n]
}