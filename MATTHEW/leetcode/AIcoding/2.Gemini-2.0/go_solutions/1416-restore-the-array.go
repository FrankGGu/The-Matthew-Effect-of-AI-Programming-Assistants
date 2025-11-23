func restoreArray(s string, k int) int {
    n := len(s)
    dp := make([]int, n+1)
    dp[n] = 1
    mod := 1000000007

    for i := n - 1; i >= 0; i-- {
        if s[i] == '0' {
            continue
        }
        num := 0
        for j := i; j < n; j++ {
            num = num*10 + int(s[j]-'0')
            if num > k {
                break
            }
            dp[i] = (dp[i] + dp[j+1]) % mod
        }
    }

    return dp[0]
}