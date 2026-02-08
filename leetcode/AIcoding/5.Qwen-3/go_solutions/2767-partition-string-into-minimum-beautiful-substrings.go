package main

func minNumberOfBeautifulSubstrings(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = 1 << 30
    }
    dp[0] = 0
    for i := 0; i < n; i++ {
        if dp[i] == 1<<30 {
            continue
        }
        for j := i + 1; j <= n; j++ {
            substr := s[i:j]
            if isBeautiful(substr) {
                dp[j] = min(dp[j], dp[i]+1)
            }
        }
    }
    return dp[n]
}

func isBeautiful(s string) bool {
    num := 0
    for _, c := range s {
        num = num*2 + int(c-'0')
    }
    return (num & (num - 1)) == 0
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}