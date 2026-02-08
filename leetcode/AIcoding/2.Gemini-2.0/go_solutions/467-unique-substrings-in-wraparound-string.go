func findSubstringInWraproundString(p string) int {
    n := len(p)
    if n == 0 {
        return 0
    }
    dp := make([]int, 26)
    maxLen := 0
    for i := 0; i < n; i++ {
        if i > 0 && (p[i] == p[i-1]+1 || (p[i-1] == 'z' && p[i] == 'a')) {
            maxLen++
        } else {
            maxLen = 1
        }
        index := p[i] - 'a'
        dp[index] = max(dp[index], maxLen)
    }
    ans := 0
    for i := 0; i < 26; i++ {
        ans += dp[i]
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}