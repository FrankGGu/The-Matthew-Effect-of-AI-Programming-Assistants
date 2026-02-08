func numDecodings(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }
    dp := make([]int, n+1)
    dp[0] = 1
    if s[0] == '0' {
        dp[1] = 0
    } else {
        dp[1] = 1
    }
    for i := 2; i <= n; i++ {
        oneDigit, _ := strconv.Atoi(s[i-1 : i])
        twoDigits, _ := strconv.Atoi(s[i-2 : i])
        if oneDigit >= 1 {
            dp[i] += dp[i-1]
        }
        if twoDigits >= 10 && twoDigits <= 26 {
            dp[i] += dp[i-2]
        }
    }
    return dp[n]
}