func minimumBeautifulSubstrings(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    powerOf5 := make(map[string]bool)
    maxLen := 0
    for p := 1; p < 1<<20; p *= 5 {
        bin := strconv.FormatInt(int64(p), 2)
        powerOf5[bin] = true
        if len(bin) > maxLen {
            maxLen = len(bin)
        }
    }

    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = n + 1
    }

    for i := 1; i <= n; i++ {
        for l := 1; l <= maxLen && i-l >= 0; l++ {
            if s[i-l] == '0' {
                continue
            }
            substr := s[i-l:i]
            if powerOf5[substr] {
                if dp[i-l] + 1 < dp[i] {
                    dp[i] = dp[i-l] + 1
                }
            }
        }
    }

    if dp[n] > n {
        return -1
    }
    return dp[n]
}