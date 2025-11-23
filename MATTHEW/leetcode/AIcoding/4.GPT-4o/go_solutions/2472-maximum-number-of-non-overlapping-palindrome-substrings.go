func maxPalindromes(s string, k int) int {
    n := len(s)
    dp := make([]int, n+1)
    palin := make([]bool, n)

    for i := 0; i < n; i++ {
        l, r := i, i
        for l >= 0 && r < n && s[l] == s[r] {
            if r-l+1 >= k {
                palin[l] = true
            }
            l--
            r++
        }
        l, r = i, i+1
        for l >= 0 && r < n && s[l] == s[r] {
            if r-l+1 >= k {
                palin[l] = true
            }
            l--
            r++
        }
    }

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        if palin[i-1] {
            for j := i - k; j >= 0; j-- {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }

    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}