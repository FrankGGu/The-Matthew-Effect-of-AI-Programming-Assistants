package main

func sumOfGoodSubsequences(s string) int {
    mod := 1000000007
    dp := make([]int, 26)
    total := 0
    for i := 0; i < len(s); i++ {
        c := s[i] - 'a'
        prev := dp[c]
        dp[c] = (dp[c] + 1) % mod
        for j := 0; j < 26; j++ {
            if j != int(c) {
                dp[c] = (dp[c] + dp[j]) % mod
            }
        }
        total = (total + dp[c]) % mod
    }
    return total
}