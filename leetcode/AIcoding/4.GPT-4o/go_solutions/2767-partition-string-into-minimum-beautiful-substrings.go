func minimumBeautifulSubstrings(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := range dp {
        dp[i] = n + 1
    }
    dp[0] = 0

    for i := 1; i <= n; i++ {
        for j := i; j > 0; j-- {
            if isBeautiful(s[j-1:i]) {
                dp[i] = min(dp[i], dp[j-1]+1)
            }
        }
    }
    if dp[n] == n+1 {
        return -1
    }
    return dp[n]
}

func isBeautiful(s string) bool {
    if s[0] == '0' {
        return false
    }
    num := 0
    for _, ch := range s {
        num = num*2 + int(ch-'0')
    }
    return num > 0 && (num&(num-1)) == 0
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}