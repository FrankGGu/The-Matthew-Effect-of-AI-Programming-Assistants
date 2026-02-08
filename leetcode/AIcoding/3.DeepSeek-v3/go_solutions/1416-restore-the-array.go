func numberOfArrays(s string, k int) int {
    mod := int(1e9 + 7)
    n := len(s)
    dp := make([]int, n+1)
    dp[0] = 1

    for i := 1; i <= n; i++ {
        for j := 1; j <= 10; j++ {
            if i-j < 0 {
                break
            }
            numStr := s[i-j:i]
            if numStr[0] == '0' {
                continue
            }
            num, _ := strconv.Atoi(numStr)
            if num > k {
                continue
            }
            dp[i] = (dp[i] + dp[i-j]) % mod
        }
    }

    return dp[n]
}