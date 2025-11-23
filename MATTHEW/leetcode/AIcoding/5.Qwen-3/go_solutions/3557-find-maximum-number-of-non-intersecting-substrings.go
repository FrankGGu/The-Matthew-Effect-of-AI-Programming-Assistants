package main

func maxSubstringCount(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j := 0; j < i; j++ {
            if s[j:i] == reverse(s[j:i]) && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
            }
        }
    }
    return dp[n]
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}